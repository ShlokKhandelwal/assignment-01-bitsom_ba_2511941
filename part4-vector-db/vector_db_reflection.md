## Vector DB Use Case

A traditional keyword-based search would not suffice for a law firm wanting
to search 500-page contracts using plain English questions. Keyword search
works by matching exact words — if a lawyer asks "What are the termination
clauses?", a keyword system would only return paragraphs containing the
literal word "termination". It would completely miss relevant sections that
use synonymous language such as "contract dissolution", "exit provisions",
or "grounds for ending the agreement", even though these mean exactly the
same thing in a legal context.

This is a fundamental limitation of keyword search — it understands words
but not meaning. Legal documents are particularly prone to this problem
because lawyers use varied, formal, and often archaic language to express
the same concepts across different contracts.

A vector database solves this problem by converting both the contract text
and the lawyer's question into numerical embeddings — mathematical
representations that capture semantic meaning. When a lawyer asks "What are
the termination clauses?", the system converts this question into a vector
and searches for contract paragraphs whose vectors are closest in meaning,
regardless of the exact words used.

In practice, the system would work as follows: first, the 500-page contract
is split into smaller chunks (paragraphs or sections). Each chunk is
converted into an embedding using a language model and stored in a vector
database such as Pinecone or ChromaDB. When a lawyer submits a plain English
question, it is also converted into an embedding and the vector database
returns the most semantically similar contract sections instantly.

This approach makes contract review dramatically faster, more accurate, and
accessible to non-technical legal staff.
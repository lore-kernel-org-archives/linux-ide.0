From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Implementing NVMHCI...
Date: Sun, 12 Apr 2009 10:11:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904120950050.4583@localhost.localdomain>
References: <20090412091228.GA29937@elte.hu> <Pine.LNX.4.62.0904121806060.9521@tamago.serverit.net> <20090412162018.6c1507b4@lxorguk.ukuu.org.uk> <49E213AE.4060506@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751684AbZDLRSH@vger.kernel.org>
In-Reply-To: <49E213AE.4060506@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Szabolcs Szakacsits <szaka@ntfs-3g.com>, Grant Grundler <grundler@google.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-ide@vger.kernel.org



On Sun, 12 Apr 2009, Avi Kivity wrote:
> 
> A quick test shows that it can.  I didn't try mmap(), but copying files around
> worked.

You being who you are, I'm assuming you're doing this in a virtual 
environment, so you might be able to see the IO patterns..

Can you tell if it does the IO in chunks of 16kB or smaller? That can be 
hard to see with trivial tests (since any filesystem will try to chunk up 
writes regardless of how small the cache entry is, and on file creation it 
will have to write the full 16kB anyway just to initialize the newly 
allocated blocks on disk), but there's a couple of things that should be 
reasonably good litmus tests of what WNT does internally:

 - create a big file, then rewrite just a few bytes in it, and look at the 
   IO pattern of the result. Does it actually do the rewrite IO as one 
   16kB IO, or does it do sub-blocking?

   If the latter, then the 16kB thing is just a filesystem layout issue, 
   not an internal block-size issue, and WNT would likely have exactly the 
   same issues as Linux.

 - can you tell how many small files it will cache in RAM without doing 
   IO? If it always uses 16kB blocks for caching, it will be able to cache 
   a _lot_ fewer files in the same amount of RAM than with a smaller block 
   size.

Of course, the _really_ conclusive thing (in a virtualized environment) is 
to just make the virtual disk only able to do 16kB IO accesses (and with 
16kB alignment). IOW, actually emulate a disk with a 16kB hard sector 
size, and reporting a 16kB sector size to the READ CAPACITY command. If it 
works then, then clearly WNT has no issues with bigger sectors.

			Linus

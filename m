From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] ide: Fix file references in drivers/ide/
Date: Mon, 10 Oct 2011 20:59:46 +0200
Message-ID: <1318273186.18122.16.camel@x61.thuisdomein>
References: <1317683499.5990.2.camel@LAPJFS> <4E933B4C.5050104@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E933B4C.5050104@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Johann Felix Soden <johfel@gmx.de>, Linus Torvalds <torvalds@linux-foundation.org>, trivial@kernel.org, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: linux-ide@vger.kernel.org

On Mon, 2011-10-10 at 11:37 -0700, Randy Dunlap wrote:
> From: Johann Felix Soden <johfel@users.sourceforge.net>
> 
> Fix file references in drivers/ide/
> 
> There are a lot of file references to now moved or deleted files in the
> whole tree, especially in documentation and Kconfig files.

Yes, there's lots of fun to be had by cleaning up those references.

Do note that I already cleaned up broken references (from anywhere in
the tree) to files in Documentation/ some time ago. See commit
395cf9691d72173d8cdaa613c5f0255f993af94b ("doc: fix broken references"),
which is now in trivial/for-next. So that's another part of this job
that's already been done. 


Paul Bolle

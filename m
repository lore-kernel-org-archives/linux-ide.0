From: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: PATCH: (Discussion) Stop IDE legacy ISA probes on PCI systems
Date: Tue, 28 Dec 2004 11:58:01 +0800
Message-ID: <2cd57c90041227195893509d3@mail.gmail.com>
References: <1104156823.20898.21.camel@localhost.localdomain>
	 <y2a7jn34f4h.fsf@cartman.at.fivegeeks.net>
	 <Pine.LNX.4.58.0412271629270.2353@ppc970.osdl.org>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.200]:15933 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262058AbUL1D6C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Dec 2004 22:58:02 -0500
Received: by rproxy.gmail.com with SMTP id 40so190433rnz
        for <linux-ide@vger.kernel.org>; Mon, 27 Dec 2004 19:58:01 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0412271629270.2353@ppc970.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adam Sampson <azz@us-lot.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

This should solve the problem. 

              coywolf


--- linux-2.6.10/include/asm-i386/ide.h 2004-10-19 05:53:13.000000000 +0800
+++ linux-2.6.10-cy/include/asm-i386/ide.h      2004-12-28
11:45:38.000000000 +0800
@@ -44,13 +44,18 @@ static __inline__ unsigned long ide_defa
        switch (index) {
                case 0: return 0x1f0;
                case 1: return 0x170;
-               case 2: return 0x1e8;
-               case 3: return 0x168;
-               case 4: return 0x1e0;
-               case 5: return 0x160;
-               default:
-                       return 0;
        }
+
+       if (pci_find_device(PCI_ANY_ID, PCI_ANY_ID, NULL) == NULL) {
+               switch (index) {
+                       case 2: return 0x1e8;
+                       case 3: return 0x168;
+                       case 4: return 0x1e0;
+                       case 5: return 0x160;
+               }
+       }
+
+       return 0;
 }

 #define IDE_ARCH_OBSOLETE_INIT


On Mon, 27 Dec 2004 16:29:52 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Mon, 27 Dec 2004, Adam Sampson wrote:
> >
> > I don't think that code will have the intended effect, unless your
> > GCC has some funny ideas about switch statements...
> 
> Indeed. That if-statement is unreachable and has no effect.
> 
>                 Linus
> -

-- 
Coywolf Qi Hunt
Homepage http://sosdg.org/~coywolf/

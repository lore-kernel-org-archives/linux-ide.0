From: "Shai Fultheim" <shai@ftcon.com>
Subject: RE: Multiple (ICH3) IDE-controllers in a system
Date: Thu, 6 May 2004 12:18:55 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405061918.BLI57844@ms6.netsolmail.com>
References: <20040506064546.GA239@ucw.cz>
Reply-To: <shai@ftcon.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omr4.netsolmail.com ([216.168.230.140]:22239 "EHLO
	omr4.netsolmail.com") by vger.kernel.org with ESMTP id S261928AbUEFTTz
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 May 2004 15:19:55 -0400
In-Reply-To: <20040506064546.GA239@ucw.cz>
List-Id: linux-ide@vger.kernel.org
To: 'Vojtech Pavlik' <vojtech@suse.cz>, 'Bartlomiej Zolnierkiewicz' <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Ok.
I would suggest one of the followings:
1. If we can't identify those machine, I would recommend to drop that patch,
since probably the BIOS is taking care of it nowadays.
2. If we believe we can't do (1) above, lets have it rest only the first
controller it is being called for.  This will make any of the other
controllers usable if their ports are set right.

Any comments?
 

--Shai


-----Original Message-----
From: linux-ide-owner@vger.kernel.org
[mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Vojtech Pavlik
Sent: Wednesday, May 05, 2004 23:46
To: Bartlomiej Zolnierkiewicz
Cc: shai@ftcon.com; linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: Multiple (ICH3) IDE-controllers in a system

On Wed, May 05, 2004 at 05:16:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi Vojtech,
> 
> Do I correctly assume that these fixups for Intel chipsets are from you?

Yes.

>
http://linus.bkbits.net:8080/linux-2.5/cset@3cfbacdfzHvfqp0Sa45QXt9pNn3LNg?n
av=index.html|src/|src/arch|src/arch/i386|src/arch/i386/pci|related/arch/i38
6/pci/fixup.c
>
http://linus.bkbits.net:8080/linux-2.5/cset@3cfcec0fOJreGFyCWkPeT7EWiydYFw?n
av=index.html|src/|src/arch|src/arch/i386|src/arch/i386/pci|related/arch/i38
6/pci/fixup.c
> 
> Care to explain why 'trash' fixup is needed in 2.6 but not in 2.4?

Because 2.4 was never used on the affected machines, where this fixup
was needed - those machines sere putting nonsense into the BARs. I don't
recall exactly what model they were, though I remember they were one of
the first machines with ICH MMIO support.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


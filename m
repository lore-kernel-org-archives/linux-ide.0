From: berthiaume_wayne@emc.com
Subject: RE: Filesystem corruption in kernels 2.4.19, 2.4.20, 2.4.21
Date: Fri, 20 Jun 2003 08:31:35 -0400
Sender: linux-newbie-owner@vger.kernel.org
Message-ID: <93F527C91A6ED411AFE10050040665D007AA86FA@corpusmx1.us.dg.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-newbie-owner@vger.kernel.org>
To: beolach@juno.com, linux-newbie@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

	Conway, what other patches do you use beside the patches from
Promise? Were the patches from Promise for 48LBA? If so, as you have already
noted, these are no longer needed in lk 2.4.19 and onward. As for your
issue, I, too, had the same battle; however, it was centered around
reiserfs, using disk caching in conjunction with the write barrier and data
logging patches, and powerfail scenarios. With lots of help from Jens Axboe
and Chris Mason of SuSE, the problem was finally overcome. There are a
series of patches to resolve this via SuSE. Their kernel source contains
many fixes in this area and you should contact them. Jens usually monitors
this mailinglist; however, Chris can be also found at
reiserfs-list@namesys.com mailinglist. Either can be contacted thru SuSE.
Regards,
Wayne.

-----Original Message-----
From: beolach@juno.com [mailto:beolach@juno.com]
Sent: Thursday, June 19, 2003 4:48 PM
To: linux-newbie@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Subject: Filesystem corruption in kernels 2.4.19, 2.4.20, 2.4.21


I've been having problems with major filesystem corruption on kernels
2.4.19, 2.4.20, and 2.4.21.
I'm pretty sure it's a problem with the driver for the PCI expansion IDE
controller the drives are on,
and I've reported this problem to the manufacturer (Promise Technology
Inc, www.promise.com),
but I haven't really gotten any help from them.  I've been considering
sending this to the kernel mailing
list, but I'm a little in awe of all the hardcore coders there, so I
figured I'd see if I could get any help
here first.

------------------------------------8<--------------------------------------
----
Any help resolving this would be appreciated,
Conway S. Smith
-
To unsubscribe from this list: send the line "unsubscribe linux-newbie" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.linux-learn.org/faqs

From: Stuart_Hayes@Dell.com
Subject: ide-tape.c (vs. st.c / ide-scsi.c)
Date: Fri, 26 Sep 2003 16:55:00 -0500
Sender: linux-tape-owner@vger.kernel.org
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F128A1F@ausx2kmpc106.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tape-owner@vger.kernel.org>
To: linux-ide@vger.kernel.org, linux-tape@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Does using ide-tape have any advantages over using st.c / ide-scsi for
controlling ATAPI tape drives, other than the following?

-> ide-tape supports DSC overlap (do any drives still support this?  I know
that QIC157D required support, but I also know that at least some modern
drives don't support this.)

-> ide-tape has the read/write pipeline (which I don't think would offer any
advantage for tape drives that have a reasonable internal buffer)

-> ide-tape supports the Onstream IDE tape drives

I've been working on some bug fixes for this driver, and, the more I look at
it, the more I wonder if I'm doing the right thing...

Thanks!
Stuart
stuart_hayes@dell.com





From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: [DISSCUSS] Iinux raid striped aligned write over xfs
Date: Mon, 22 Jan 2007 13:49:46 +0200
Message-ID: <5d96567b0701220349r1e3386beib30f46bc3b635cb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:12677 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbXAVLtr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jan 2007 06:49:47 -0500
Received: by py-out-1112.google.com with SMTP id a29so622230pyi
        for <linux-ide@vger.kernel.org>; Mon, 22 Jan 2007 03:49:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jan hello
I am referring to xfs awareness over linux software raid .
I noticed that though all single file extents beginnings are aligned
over a raid
stripe unit, they do not end aligned. this thing degrades a sequential read
performance over a raid.
I have fixed the code as follows:

--- linux-2.6.17-SMP/fs/xfs/xfs_iomap.c 2007-01-16 08:53:52.000000000 +0000
+++ linux-2.6.17-Vanilla/fs/xfs/xfs_iomap.c     2006-06-18
01:49:35.000000000 +0000
@@ -441,8 +441,8 @@ xfs_iomap_write_direct(
        if (unlikely(rt)) {
                if (!(extsz = ip->i_d.di_extsize))
                        extsz = mp->m_sb.sb_rextsize;
-       } else {
-        extsz =  mp->m_dalign; // raz fix alignment to raid stripe unit
+       } else {
+               extsz = ip->i_d.di_extsize;
        }

        isize = ip->i_d.di_size;
@@ -663,7 +663,7 @@ xfs_iomap_write_delay(
                if (!(extsz = ip->i_d.di_extsize))
                        extsz = mp->m_sb.sb_rextsize;
        } else {
-               extsz =  mp->m_dalign; //  raz fix alignment to raid stripe unit
+               extsz = ip->i_d.di_extsize;
        }

        offset_fsb = XFS_B_TO_FSBT(mp, offset);



This seems to work.
My question is , is there a mistake that i have made which i do not
see ?

I would realy appreciate any comment .
thank you
-- 
Raz

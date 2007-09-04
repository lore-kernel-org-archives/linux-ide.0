From: Raz <raziebe@gmail.com>
Subject: a disk timeout and a disk state
Date: Tue, 4 Sep 2007 10:09:40 +0300
Message-ID: <5d96567b0709040009o2b1580fel4bcd91e629b5bef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:16342 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbXIDHJm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Sep 2007 03:09:42 -0400
Received: by nf-out-0910.google.com with SMTP id f5so1366922nfh
        for <linux-ide@vger.kernel.org>; Tue, 04 Sep 2007 00:09:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Hello

We have in our machines several sata (mostly maxtor-segate) disks in an array.
These disks generate too many ata-io errors at clients sites.
>From raid1 code I have learned that a re-write sometimes fixes a disk.

Question: Why ?
Question: Does it always work ?
Question: Does rewriting a slow sector also reduces a disk error rate,
does it make any sense ?

thank you
-- 
Raz

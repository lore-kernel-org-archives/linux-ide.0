From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.22.6 sata_sil device errors & timeouts
Date: Thu, 27 Sep 2007 16:15:44 +0900
Message-ID: <46FB58A0.3040109@gmail.com>
References: <76366b180709170135v6c46f3d6qd3586ea79f9abc2@mail.gmail.com>  <46EE4679.7030600@gmail.com>  <76366b180709170904i7b2f5ab0o8605eb899d20f921@mail.gmail.com>  <46EEB449.8010305@gmail.com>  <76366b180709171205v5783fb9ave52b7e999da96f07@mail.gmail.com>  <76366b180709171226j5a299502q1a13f158d9b704aa@mail.gmail.com>  <Pine.LNX.4.63.0709171433120.28104@trinity.phys.uwm.edu>  <76366b180709171406g61f09f39la8deeb3201ad0e37@mail.gmail.com>  <Pine.LNX.4.63.0709180028270.28104@trinity.phys.uwm.edu> <76366b180709180736h57f956ccld8fba04070f02408@mail.gmail.com> <Pine.LNX.4.63.0709181032270.17786@trinity.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:46872 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757286AbXI0SRV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 14:17:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3255828wah
        for <linux-ide@vger.kernel.org>; Thu, 27 Sep 2007 11:17:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0709181032270.17786@trinity.phys.uwm.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Andrew Paprocki <andrew.m.paprocki@gmail.com>, linux-ide@vger.kernel.org

Bruce Allen wrote:
> Andrew: thanks for isolating this problem.
> 
> Tejun: any thoughts?  The STRANGE_BUFFER_LENGTH problem is fixed in the
> code that Andrew is running.  The problem is provoked with '-o on' which
> goes via a TASKFILE ioctl.

I suppose you mean HDIO_DRIVE_TASK, right?  libata doesn't implement
HDIO_DRIVE_TASKFILE and it probably never will.  I'll test it next week
when I get back.  Thanks.

-- 
tejun


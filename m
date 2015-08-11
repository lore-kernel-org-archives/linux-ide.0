From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: NCQ-related READ/WRITE frozen ATA errors with Intel C220 and
 Intel s3610 SSDs
Date: Tue, 11 Aug 2015 14:28:18 +0300
Message-ID: <CABYiri-ov_=mzoNZp_g_K0RFu+i2nG50Eg-ed+-B37ZOzvB6Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36148 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964874AbbHKL2j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Aug 2015 07:28:39 -0400
Received: by lbbpu9 with SMTP id pu9so83933119lbb.3
        for <linux-ide@vger.kernel.org>; Tue, 11 Aug 2015 04:28:38 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

sorry for a rude top-post and please CC me in a main discussion afterward.

Since yesterday since I found the same issue with C602 and S3710 in
mine production and stood in horror for a couple of moments, I made a
small amount of runs with fio to check if the issue is here or not for
certain configuration, here are preliminary results:

- isci in all LTS are affected, if I could use this wording in
appearance of an obviously broken hardware counterparts,
- setting device`s qd=1 is *not* fixing the issue for me,
- setting noncq for a specific link closes the deal.

Therefore, I`d like to propose to either add hook from scsi code to
set horkage_on on setting queue_depth to 1 and removing it back at
runtime, or to reword libata faq [1], as for me there is a clear
difference between actual NCQ disablement for a link/controller and
setting queue depth to 1, the bus resets are still appearing in a
second case.

1. https://ata.wiki.kernel.org/index.php/Libata_FAQ

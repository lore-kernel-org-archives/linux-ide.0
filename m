From: Pallav Bose <pallavbose@gmail.com>
Subject: Submitting a BIO from a work queue
Date: Wed, 20 Jul 2011 11:20:40 -0400
Message-ID: <CANk-0YtMSmnVw+0BVb=Grj8qhEmV-XDDX3QpxaB=7qvf19nyOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37414 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab1GTPVB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jul 2011 11:21:01 -0400
Received: by iyb12 with SMTP id 12so272110iyb.19
        for <linux-ide@vger.kernel.org>; Wed, 20 Jul 2011 08:21:00 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Ganesh Karuppur Rajagopalan <ganesh.kr356@gmail.com>

Hello,

I'm using 2.6.39.1 version of the Linux kernel. In my block device
driver, I'm queuing a=A0struct work_struct=A0from the bottom half of th=
e
interrupt handler, i.e., in the=A0->bi_end_io=A0function of a previousl=
y
submitted BIO. The work queue handler function then submits the next
BIO to be processed. The system becomes unresponsive when we do this.
We believe that calling=A0submit_bio()=A0from our work queue handler
function in this setup is causing the problem. Can someone explain
what the problem is in this scenario?

Thanks,
Pallav

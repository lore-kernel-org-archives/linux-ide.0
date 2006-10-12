From: "Fajun Chen" <fajunchen@gmail.com>
Subject: How to test SATA NCQ feature
Date: Thu, 12 Oct 2006 10:30:48 -0600
Message-ID: <8202f4270610120930u2da27058u77c4384f1bd4cda2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:56302 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932675AbWJLQat (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Oct 2006 12:30:49 -0400
Received: by nz-out-0102.google.com with SMTP id n1so288847nzf
        for <linux-ide@vger.kernel.org>; Thu, 12 Oct 2006 09:30:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hi Folks,

I'm writing a program to test SATA Sil3124 NCQ feature.  I assume NCQ
is supported by libata by default, correct?  Multi threading approach
is used to send AT commands to device asynchronously.  I can verify
that data are sent to the device and read back correctly, but I don't
know how to verify if NCQ works.  Do I expect to see consistent
performance gain in random read/write in NCQ mode?

Thanks,
Fajun

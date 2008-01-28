From: "Mike Zheng" <mail2mz@gmail.com>
Subject: Marvel 88SE6121 driver
Date: Mon, 28 Jan 2008 09:22:42 -0500
Message-ID: <7f96c8390801280622w1edf1784p6144651d3233b8ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.225]:47018 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412AbYA1OWp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jan 2008 09:22:45 -0500
Received: by wr-out-0506.google.com with SMTP id c49so692189wra.1
        for <linux-ide@vger.kernel.org>; Mon, 28 Jan 2008 06:22:43 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, mlord@pobox.com, linux-ide@vger.kernel.org

Hi All,

I am doing development of device driver of  88SE6121 on Kernel 2.4 for
PowerPC 8568 board, which is a BIG endian CPU.

>From PCI config space, the VENDOR_ID and DEVICE_ID are correct for my
driver. However the PCI_COMMAND register of 88SE6121 I got is 0x7,
which is the same as default value. Based on the document,  it has to
be 0x0207 to enable interrupt. However I always failed to do so, the
value remains 0x7 after it is re-assigned to the new value 0x0207. So
that I have no interrupt from PCIe as INTA. Do you have any idea on
this issue?

Thanks for your help,

Mike Zheng

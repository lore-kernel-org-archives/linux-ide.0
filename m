From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Marvel 88SE6121 driver
Date: Mon, 28 Jan 2008 18:09:10 +0300
Message-ID: <479DF016.7070100@ru.mvista.com>
References: <7f96c8390801280622w1edf1784p6144651d3233b8ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:63221 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751155AbYA1PIR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jan 2008 10:08:17 -0500
In-Reply-To: <7f96c8390801280622w1edf1784p6144651d3233b8ca@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mike Zheng <mail2mz@gmail.com>
Cc: htejun@gmail.com, mlord@pobox.com, linux-ide@vger.kernel.org

Hello.

Mike Zheng wrote:

> From PCI config space, the VENDOR_ID and DEVICE_ID are correct for my
> driver. However the PCI_COMMAND register of 88SE6121 I got is 0x7,
> which is the same as default value. Based on the document,  it has to
> be 0x0207 to enable interrupt. However I always failed to do so, the

    Bit 10 (mask 0x0200) is fast back-to-back enable, what does it have to do 
with iterrupts.

> value remains 0x7 after it is re-assigned to the new value 0x0207. So

    This means that fast back-to-back is not supported

> that I have no interrupt from PCIe as INTA. Do you have any idea on
> this issue?

    There's also bit 11 (mask 0x0400) meaning INTx emulation *disable*.

> Thanks for your help,

> Mike Zheng

MBR, Sergei

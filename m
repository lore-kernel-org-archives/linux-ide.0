From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Pls help for LibATA caused kernel temporary hung.
Date: Mon, 28 Jun 2010 05:02:54 -0400
Message-ID: <4C28653E.4080908@garzik.org>
References: <AANLkTinbQHdo40Drqc5Ydur5lCrAktHHDig45HDrC6s1@mail.gmail.com> <4C2777D3.1050208@gmail.com> <AANLkTim-sAoDmNDqlM4k8WKeQJ0mTcxcm1VyO968BQZC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58743 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab0F1JC7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jun 2010 05:02:59 -0400
Received: by gwaa18 with SMTP id a18so1892752gwa.19
        for <linux-ide@vger.kernel.org>; Mon, 28 Jun 2010 02:02:58 -0700 (PDT)
In-Reply-To: <AANLkTim-sAoDmNDqlM4k8WKeQJ0mTcxcm1VyO968BQZC@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Li <simon.jiyou@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On 06/28/2010 03:38 AM, Simon Li wrote:
> May 25 15:55:06 shctc-xq-ems22-me18 kernel: ata3: status=0x25 {
> DeviceFault CorrectedError Error }

> May 25 15:59:59 shctc-xq-ems22-me18 kernel: ata3: status=0x25 {
> DeviceFault CorrectedError Error }

> Jun  2 10:54:06 shctc-xm-ems21-me18 kernel: ata2: status=0x25 {
> DeviceFault CorrectedError Error }

> Jun  2 10:54:08 shctc-xm-ems21-me18 kernel: ata2: status=0x25 {
> DeviceFault CorrectedError Error }

> Jun  2 10:54:18 shctc-xm-ems21-me18 kernel: ata2: status=0x25 {
> DeviceFault CorrectedError Error }

Your hardware is returning errors, which libata is dutifully reporting...

	Jeff



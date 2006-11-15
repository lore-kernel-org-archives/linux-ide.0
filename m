From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata_piix on Thinkpad T30 - qc timeout on boot
Date: Wed, 15 Nov 2006 21:06:15 +0900
Message-ID: <455B02B7.8030502@gmail.com>
References: <1163563453.3100.24.camel@dv>	<1163569390.4410.8.camel@dv> <20061115114748.7a51d03c@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.201]:42542 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S966571AbWKOMGX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 07:06:23 -0500
Received: by nz-out-0102.google.com with SMTP id l1so27525nzf
        for <linux-ide@vger.kernel.org>; Wed, 15 Nov 2006 04:06:22 -0800 (PST)
In-Reply-To: <20061115114748.7a51d03c@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Roskin <proski@gnu.org>, linux-ide@vger.kernel.org

Alan wrote:
> On Wed, 15 Nov 2006 00:43:10 -0500
> Pavel Roskin <proski@gnu.org> wrote:
> 
>> Hello again and sorry for post scriptum.
>>
>> On Tue, 2006-11-14 at 23:04 -0500, Pavel Roskin wrote:
>>
>>> ata2.01: qc timeout (cmd 0xa1)
>>> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
> 
> Just about everyone is seeing this with the new EH code and current
> libata. If you back out the EH changes life seems to go back to normal.

If you're talking about phantom device problem, it isn't related to EH 
itself.  It's because of irq-pio which was merged together with EH and 
the fix is polling IDENTIFY.

-- 
tejun

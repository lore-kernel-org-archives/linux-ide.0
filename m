From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_sil: fix uninitialized variable use when 	sil_scr_read()
 fails
Date: Mon, 26 Oct 2009 16:12:43 +0100
Message-ID: <4AE5BC6B.7060804@kernel.org>
References: <20091020153456.9104e044.yuasa@linux-mips.org>	 <4ADE9563.2030705@kernel.org> <21eaeb5a0910211717w5692ce4em74482c7e5d4f5b9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39207 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbZJZPLi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Oct 2009 11:11:38 -0400
In-Reply-To: <21eaeb5a0910211717w5692ce4em74482c7e5d4f5b9c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yuasa Yoichi <yuasa@linux-mips.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Yuasa Yoichi wrote:
>> The first usage of that is
>>
>>  sil_scr_read(&ap->link, SCR_ERROR, &serror);
>>
>> which sets the value.  So, I don't think the patch is necessary.  If
>> it triggers a compile warning, putting uninitialized_var() macro will
>> be more appropriate.
> 
> If sil_scr_read() is error, 'serror' is not initialized.
> After that, the wrong bits add to 'ap->link.eh_info.serror' when
> 'serror & SERR_PHYRDT_CHG' is true.

On the controller, sil_scr_read(SCR_ERROR) can never fail.  If it ever
fails, the whole thing will break anyway.

Thanks.

-- 
tejun

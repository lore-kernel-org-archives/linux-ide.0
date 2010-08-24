From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil boot failure with 2.6.35
Date: Tue, 24 Aug 2010 17:16:51 +0200
Message-ID: <4C73E263.5050102@kernel.org>
References: <4C6EC878020000780001146D@vpn.id2.novell.com> <4C6ED603.9020602@garzik.org> <4C724D3E.50404@kernel.org> <4C728C5E0200007800011887@vpn.id2.novell.com> <4C727E80.3060402@kernel.org> <4C72B4250200007800011998@vpn.id2.novell.com> <4C73CE8A.406@kernel.org> <4C73FEA60200007800011F51@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43245 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755388Ab0HXPWR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Aug 2010 11:22:17 -0400
In-Reply-To: <4C73FEA60200007800011F51@vpn.id2.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Jeff Garzik <jeff@garzik.org>, jgarzik@redhat.com, linux-ide@vger.kernel.org

On 08/24/2010 05:17 PM, Jan Beulich wrote:
>> The only thing I can think of is the following.  Can you please try
>> this one?  If this one fails, we might have to resort to bisecting.
>> It's very weird.  The sff common code is used by other controllers but
>> until now the problem is only being reported on sata_sil.
> 
> Sorry - again no (visible) difference.

Any chance I can persuade you into bisecting the problem? :-) Also,
can you please attach the output of lspci -nn output and .config?

Thanks.

-- 
tejun

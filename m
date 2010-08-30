From: Tejun Heo <teheo@novell.com>
Subject: Re: sata_sil boot failure with 2.6.35
Date: Mon, 30 Aug 2010 15:42:23 +0200
Message-ID: <4C7BB53F.2080301@novell.com>
References: <4C6EC878020000780001146D@vpn.id2.novell.com> <4C6ED603.9020602@garzik.org> <4C724D3E.50404@kernel.org> <4C728C5E0200007800011887@vpn.id2.novell.com> <4C727E80.3060402@kernel.org> <4C72B4250200007800011998@vpn.id2.novell.com> <4C73CE8A.406@kernel.org> <4C73FEA60200007800011F51@vpn.id2.novell.com> <4C73E263.5050102@kernel.org> <4C74EE7902000078000120E2@vpn.id2.novell.com> <4C7BB498.2010000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37967 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752917Ab0H3Nm0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Aug 2010 09:42:26 -0400
In-Reply-To: <4C7BB498.2010000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Jeff Garzik <jeff@garzik.org>, jgarzik@redhat.com, linux-ide@vger.kernel.org

On 08/30/2010 03:39 PM, Tejun Heo wrote:
> Hello,
> 
> On 08/25/2010 10:20 AM, Jan Beulich wrote:
>>> Any chance I can persuade you into bisecting the problem? :-) Also,
>>> can you please attach the output of lspci -nn output and .config?
>>
>> I'll see if I can find time, but I can give no estimate. However, the
>> box I see this on (AMD Sahara Rev F) likely has a number of
>> duplicates in our labs, so maybe you could try reproducing it there?
> 
> I just tried 3512 and 3112 but still can't reproduce the problem.
> I'll see if I can get the same model hooked onto a remote console.

Just one more thing before going forward with that.  Can you please
test the current libata-dev#upstream[1] and see the problem is still
there?  Also, can you please post your .config?

Thanks.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream

-- 
tejun

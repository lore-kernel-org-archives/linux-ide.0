From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream] ahci: add HFLAG_YES_FBS and apply it to 88SE9128
Date: Wed, 08 Dec 2010 19:13:55 +0100
Message-ID: <4CFFCAE3.1090106@kernel.org>
References: <4C4AFE7C.5070506@kernel.org> <4CF45BC0.2030701@iki.fi> <4CF4FCBE.2060406@kernel.org> <4CF55A4B.1020402@iki.fi> <4CFE8EE2.1060908@iki.fi> <4CFF67B6.7090805@kernel.org> <4CFFC9D0.2090803@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39623 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755550Ab0LHSOU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Dec 2010 13:14:20 -0500
In-Reply-To: <4CFFC9D0.2090803@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <kernel@teksavvy.com>

Hello,

On 12/08/2010 07:09 PM, Jeff Garzik wrote:
>> I'm not completely comfortable with going ahead with the patch tho.
>> It probably is okay but it's still a shot in the dark.  Is there
>> anyone with marvell contact?
> 
> I have docs for most Marvell models, but not this one; and no
> contacts...  Presumably it is some variant of their existing Marvell
> AHCI line of chips, but beyond that, you and I are both just
> guessing.

Eh, well, in that case as it's a fix one way or the other,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

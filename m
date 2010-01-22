From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream-fixes] libata-sff: remove CONFIG_NO_ATA_LEGACY
Date: Fri, 22 Jan 2010 09:48:54 +0900
Message-ID: <4B58F5F6.9090001@gmail.com>
References: <20100120142943.GE3580@faui49.informatik.uni-erlangen.de>	<4B579C4A.3040907@gmail.com> <20100121120405.1085b6d3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58886 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab0AVAqi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jan 2010 19:46:38 -0500
In-Reply-To: <20100121120405.1085b6d3@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com, Reinhard.Tartler@informatik.uni-erlangen.de, David Howells <dhowells@redhat.com>

(cc'ing David Howells, who BTW is on vacation till Feb) Hi!

On 01/21/2010 09:04 PM, Alan Cox wrote:
> On Thu, 21 Jan 2010 09:14:02 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> CONFIG_NO_ATA_LEGACY isn't used by anyone.  Drop it.
>>
>> Reported-by: Christoph Egger <siccegge@stud.informatik.uni-erlangen.de>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> Not unless this is cleared with the FRV maintainers who were using
> it and I believe may still need it.
> 
> Mr Howells ?

David, the patch in question is,

  http://lkml.org/lkml/2010/1/20/396

Does FRV still need it?

Thanks.

-- 
tejun

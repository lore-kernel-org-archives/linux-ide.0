From: Daniel Drake <dsd@gentoo.org>
Subject: Re: "Fix ATAPI transfer lengths" causes CD writing regression
Date: Tue, 30 Oct 2007 19:21:29 +0000
Message-ID: <47278439.4030801@gentoo.org>
References: <47274A5F.6070409@gentoo.org>	<20071030153417.59b9182c@the-village.bc.nu>	<47276DCA.1000808@gentoo.org> <20071030190153.373c9347@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:47048 "EHLO
	smtp121.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757626AbXJ3TVl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 15:21:41 -0400
In-Reply-To: <20071030190153.373c9347@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> I would guess Brasero is issuing a command with the length of data
> wrongly set. In the old code that might well just produce errors of the
> "Umm wtf is this data left over for ?", with the new code the drive is
> likely to change state as it knows the transfer size and that will
> *correctly* cause an HSM error and what follows.
> 
> Now the question is who gets the length wrong - Brasero or the ata
> translation code in libata

Brasero does exactly the same as my test app which I attached to my last 
mail. Is my test app wrong?

Daniel


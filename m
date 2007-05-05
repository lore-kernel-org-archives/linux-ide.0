From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.21-mm1: many processes end up in D state
Date: Sat, 05 May 2007 17:30:51 +0200
Message-ID: <463CA32B.1010505@gmail.com>
References: <200705041919.l44JJ15g009202@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:50682 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031759AbXEEPbG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 11:31:06 -0400
Received: by py-out-1112.google.com with SMTP id a29so906638pyi
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 08:31:05 -0700 (PDT)
In-Reply-To: <200705041919.l44JJ15g009202@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jirislaby@gmail.com, akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org

Mikael Pettersson wrote:
>> I.e. no freezing of ports...
> 
> Your patch to delete the 'return 1;' on error is correct,
> and makes the code match exactly the behaviour of previous
> versions of sata_promise, except for the additional error
> decoding.
> 
> ahci and sata_sil24 do the return in this situation. I don't
> yet understand why they can get away with it while sata_promise
> cannot, but for now the return should be removed.

That's because sata_sil24 and ahci call either ata_port_abort() or
ata_port_freeze() prior to finishing error_intr routine.  Both functions
abort all in-flight command and schedule EH.

--
tejun


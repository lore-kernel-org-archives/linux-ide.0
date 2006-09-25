From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata-piix: kerneldoc-error-on-ata_piixc.patch 2nd try
Date: Mon, 25 Sep 2006 15:39:08 -0400
Message-ID: <4518305C.3090906@pobox.com>
References: <451826BE.2040201@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50382 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750753AbWIYTjN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Sep 2006 15:39:13 -0400
In-Reply-To: <451826BE.2040201@nachtwindheim.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Henne <henne@nachtwindheim.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Henne wrote:
> Heres a new version of the kerneldoc error in ata_piix.c
> The old one which doesn't apply clean is in 2.6.18-mm1 and can be removed there if acked.
> 
> Greets,
> Henne
> 
> From: Henrik Kretzschmar <henne@nachtwindheim.de>
> 
> Fixes an error in kerneldoc of ata_piix.c.
> This is the 2nd try, written for 2.6.18-git4
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Several problems with your patch format:

1) your subject line includes-a-bunch-of-words-separated-by-dashes, 
which is incorrect.  Just use standard English.

2) "2nd try" should be inside the brackets ("[", "]"), so that the 
script removes it during merge

3) All comments such as the first paragraph and "Greets, Henne" should 
be moved underneath the "---" separator, so that they are not copied 
into the kernel changelog verbatim.  You force people to hand-edit your 
email before merging.

4) No need for "From:" in the email body, it duplicates the email's 
RFC822 From header.

5) Another comment "This is the 2nd try, written for 2.6.18-git4" which 
should be moved after the "---" separator.  Otherwise, it must be 
hand-edited out.



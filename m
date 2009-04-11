From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_sil & pmp ?
Date: Sat, 11 Apr 2009 12:10:33 -0600
Message-ID: <49E0DD19.2080603@gmail.com>
References: <49DF216D.6080208@gotshifted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:26549 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757731AbZDKSKi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Apr 2009 14:10:38 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1593778ywb.1
        for <linux-ide@vger.kernel.org>; Sat, 11 Apr 2009 11:10:37 -0700 (PDT)
In-Reply-To: <49DF216D.6080208@gotshifted.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hasse@gotshifted.com
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hans Holmberg wrote:
> I wonder if there is any plans to add pmp support to the sata_sil module ?
> 
> I know there's an ugly patch that kind of works, but it seems nothing 
> has happened since it was posted.

It looks like the controller does have some support for at least setting 
the PMP field in the transmitted FIS. I'm not sure if it includes 
everything that's needed for full PMP support though. I saw that there 
was some talk of a patch to add this, but I'm not sure how fully working 
it was.

The Silicon Image 311x controllers are kind of funny beasts. Technically 
since they support transparent FIS reception and interlock for all FIS 
types, you could implement just about any SATA feature such as NCQ, 
ATAPI AN, etc. by overriding the handling of the required FISes. NCQ 
might be kind of expensive though, as you'd likely have to take a whole 
lot of extra interrupts for FISes to examine to get that to work, you'd 
basically be doing most of the SATA state machine in software..

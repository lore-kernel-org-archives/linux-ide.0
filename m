From: Tim Small <tim@seoss.co.uk>
Subject: Re: failed command: WRITE FPDMA QUEUED, suspiciously on two different
 disks
Date: Wed, 24 Jun 2015 11:45:53 +0100
Message-ID: <558A8A61.7000302@seoss.co.uk>
References: <20150623190018.5wer6qdh467f5mud@m.safari.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay1.allsecuredomains.com ([78.47.251.4]:48645 "EHLO
	relay1.allsecuredomains.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751906AbbFXLSU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2015 07:18:20 -0400
In-Reply-To: <20150623190018.5wer6qdh467f5mud@m.safari.iki.fi>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sami Farin <hvtaifwkbgefbaei@gmail.com>, Linux ide Mailing List <linux-ide@vger.kernel.org>

On 23/06/15 20:00, Sami Farin wrote:
> SMART does not show problems and disks are working OK, but I have not
> ran tests recently..

Are you running smartd, or using other monitoring tools to periodically
run smartctl against these drives?  I've had problems with this sort of
vintage of WD drives aborting other commands and resetting when making
simultaneous SMART enquiries.

BTW, looks to me like the drives are on the Intel controller, is that
correct?

Tim.

-- 
South East Open Source Solutions Limited
Registered in England and Wales with company number 06134732.
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ
VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309

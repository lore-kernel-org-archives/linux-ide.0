From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
Date: Thu, 12 Apr 2012 16:05:07 -0400
Message-ID: <4F873573.10406@pobox.com>
References: <1333447938-16461-1-git-send-email-tqnguyen@apm.com> <4F7AE584.3050805@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:60816 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab2DLUFL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Apr 2012 16:05:11 -0400
In-Reply-To: <4F7AE584.3050805@mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Thang Q. Nguyen" <tqnguyen@apm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On 04/03/2012 07:56 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 03-04-2012 14:12, Thang Q. Nguyen wrote:
>
>> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
>> ---
>> Changes for v2:
>> - Use git rename feature to change the driver to the newname and for
>> easier review.
>
>> arch/powerpc/boot/dts/bluestone.dts | 21 +
>> drivers/ata/Makefile | 2 +-
>> drivers/ata/{sata_dwc_460ex.c => sata_dwc_4xx.c} | 1371
>> ++++++++++++++--------
>> 3 files changed, 904 insertions(+), 490 deletions(-)
>> rename drivers/ata/{sata_dwc_460ex.c => sata_dwc_4xx.c} (56%)
>
> You submitted a magapatch doing several things at once (some even
> needlessly) and even in two areas of the kernel. This needs proper
> splitting/description.

Agreed...




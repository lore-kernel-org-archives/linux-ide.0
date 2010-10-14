From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 12/14] ata: pata_octeon_cf: Use I/O clock rate for timing
 calculations.
Date: Thu, 14 Oct 2010 04:42:53 -0400
Message-ID: <4CB6C28D.5070805@pobox.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com> <1286492633-26885-13-git-send-email-ddaney@caviumnetworks.com> <20101011134354.GI30695@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48006 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab0JNIm6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Oct 2010 04:42:58 -0400
Received: by qyk5 with SMTP id 5so1612276qyk.19
        for <linux-ide@vger.kernel.org>; Thu, 14 Oct 2010 01:42:57 -0700 (PDT)
In-Reply-To: <20101011134354.GI30695@linux-mips.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org, linux-ide@vger.kernel.org

On 10/11/2010 09:43 AM, Ralf Baechle wrote:
> On Thu, Oct 07, 2010 at 04:03:51PM -0700, David Daney wrote:
>
>> The creation of the I/O clock domain requires some adjustments.  Since
>> the CF bus timing logic is clocked by the I/O clock, use its rate for
>> delay calculations.
>>
>> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
>> Cc: Jeff Garzik<jgarzik@pobox.com>
>> Cc: linux-ide@vger.kernel.org
>
> Haven't seen any ack yet but I assume due to the dependencies on other
> MIPS patches it'll be ok if I merge this through the MIPS tree, so I
> queued it for 2.6.37.

yep,

Acked-by: Jeff Garzik <jgarzik@redhat.com>



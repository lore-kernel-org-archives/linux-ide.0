From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
Date: Tue, 25 Nov 2008 09:04:49 -0800
Message-ID: <492C3031.2000408@caviumnetworks.com>
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com> <492C2F23.8050105@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3833 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbYKYRFA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 12:05:00 -0500
In-Reply-To: <492C2F23.8050105@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> David Daney wrote:
>> The forthcoming OCTEON SOC Compact Flash driver needs a few more
>> timing values than were available in the ata_timing table.  I add new
>> columns for write_hold, read_hold, and read_holdz times.  The values
>> were obtained from the Compact Flash specification Rev 4.1.
>>
>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
>> ---
>>  drivers/ata/libata-core.c |   76 
>> ++++++++++++++++++++++++--------------------
>>  include/linux/libata.h    |   14 ++++++--
>>  2 files changed, 52 insertions(+), 38 deletions(-)
> 
> I would be happy to go ahead and apply this...  Alan, any last minute 
> objections?
> 

Sergei had some comments that I am trying to address.  Perhaps we should 
hold off a little, while I figure out how what to do WRT those comments.

David Daney

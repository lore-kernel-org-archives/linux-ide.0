From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ahci: Turn off DMA engines when there's no device attached
Date: Wed, 24 Mar 2010 10:43:51 -0400
Message-ID: <4BAA2527.4030204@pobox.com>
References: <1268253150-24050-1-git-send-email-mjg@redhat.com> <20100324141912.GA18644@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:53434 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400Ab0CXOnz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Mar 2010 10:43:55 -0400
Received: by pzk32 with SMTP id 32so943147pzk.4
        for <linux-ide@vger.kernel.org>; Wed, 24 Mar 2010 07:43:53 -0700 (PDT)
In-Reply-To: <20100324141912.GA18644@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-ide@vger.kernel.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

On 03/24/2010 10:19 AM, Matthew Garrett wrote:
> On Wed, Mar 10, 2010 at 03:32:30PM -0500, Matthew Garrett wrote:
>> According to section 10.3.1 of the AHCI spec, PxCMD.ST must not be set
>> unless there's a device attached. Following this saves us a measurable
>> quantity of power and does not impair hotplug support. Based on a patch
>> by Kristen Carlson Accardi.
>>
>> Signed-off-by: Matthew Garrett<mjg@redhat.com>
>> Cc: Kristen Carlson Accardi<kristen.c.accardi@intel.com>
>> ---
>>   drivers/ata/ahci.c |   19 +++++++++++++++++++
>>   1 files changed, 19 insertions(+), 0 deletions(-)


(please don't top-post, it makes replying more difficult)

> Any feedback on this?

It should be fine, but I have to rebase it onto the latest upstream ahci 
(libata-dev.git#upstream), so it's been waiting on that...

	Jeff



From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Wed, 16 Mar 2016 15:12:53 -0500
Message-ID: <56E9BE45.8030101@amd.com>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
 <20160125204300.GM3628@mtj.duckdns.org> <56A73E39.70109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1on0096.outbound.protection.outlook.com ([157.56.110.96]:11200
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750953AbcCPVuN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Mar 2016 17:50:13 -0400
In-Reply-To: <56A73E39.70109@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: brijesh.singh@amd.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-ide@vger.kernel.org

Hi Tejun,


On 01/26/2016 03:36 AM, Hans de Goede wrote:
> Hi,
> 
> On 25-01-16 21:43, Tejun Heo wrote:
>> On Thu, Jan 14, 2016 at 10:31:11AM -0600, Brijesh Singh wrote:
>>> AMD Seattle SATA controller mostly conforms to AHCI interface with some
>>> special register to control SGPIO interface. In the case of an AHCI
>>> controller, the SGPIO feature is ideally implemented using the
>>> "Enclosure Management" register of the AHCI controller, but those
>>> registeres are not implemented in the Seattle SoC. Instead SoC
>>> (Rev B0 onwards) provides a 32-bit SGPIO control register which should
>>> be programmed to control the activity, locate and fault LEDs.
>>>
>>> The driver is based on ahci_platform driver.
>>>
>>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>>> CC: tj@kernel.org
>>> CC: linux-ide@vger.kernel.org
>>
>> Hans, can you please review the patch?
> 
> Done, driver looks good to me:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
>

Can we please pull this patch ? If needed then I can rebase to the tip. Given the current HW and BIOS limitation, platform driver seems like a right choice.

Thanks
Brijesh
 
> Regards,
> 
> Hans

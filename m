From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Tue, 26 Jan 2016 10:36:57 +0100
Message-ID: <56A73E39.70109@redhat.com>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
 <20160125204300.GM3628@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49226 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756351AbcAZJhE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Jan 2016 04:37:04 -0500
In-Reply-To: <20160125204300.GM3628@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-ide@vger.kernel.org

Hi,

On 25-01-16 21:43, Tejun Heo wrote:
> On Thu, Jan 14, 2016 at 10:31:11AM -0600, Brijesh Singh wrote:
>> AMD Seattle SATA controller mostly conforms to AHCI interface with some
>> special register to control SGPIO interface. In the case of an AHCI
>> controller, the SGPIO feature is ideally implemented using the
>> "Enclosure Management" register of the AHCI controller, but those
>> registeres are not implemented in the Seattle SoC. Instead SoC
>> (Rev B0 onwards) provides a 32-bit SGPIO control register which should
>> be programmed to control the activity, locate and fault LEDs.
>>
>> The driver is based on ahci_platform driver.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>> CC: tj@kernel.org
>> CC: linux-ide@vger.kernel.org
>
> Hans, can you please review the patch?

Done, driver looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

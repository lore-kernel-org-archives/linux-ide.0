From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH RFC 1/2] libahci_platform: add ahci_platform_get_of_property
Date: Thu, 19 Jun 2014 09:39:55 +0200
Message-ID: <53A293CB.3040704@redhat.com>
References: <xuwei5@hisilicon.com,kefeng.wang@linaro.org,> <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org> <1403067249-8021-2-git-send-email-zhangfei.gao@linaro.org> <20140618140352.GD11895@leverpostej> <53A24950.2020300@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40632 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755362AbaFSHkg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Jun 2014 03:40:36 -0400
In-Reply-To: <53A24950.2020300@linaro.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: "tj@kernel.org" <tj@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi,

On 06/19/2014 04:22 AM, zhangfei wrote:
> Hi Mark,
> 
> On 06/18/2014 10:03 PM, Mark Rutland wrote:
>> On Wed, Jun 18, 2014 at 05:54:08AM +0100, Zhangfei Gao wrote:
>>> Instead of setting hflags in different files,
>>> ahci_platform_get_of_property set hpriv->flags when ahci_platform_init_host
>>> according to property in dts.
>>
>> The AHCI_HFLAGS are a Linux implementation detail, so it would be nice
>> to have a good justification for each of these being turned into DT
>> properties.
> 
> Do you mean only add required property now?

No you should not add any properties at all using properties to set SoC specific quirks
is just wrong, if a device is not 100% ahci compatible you should use a SoC specific
compatible string for it, and set quirks in the kernel driver based on that.

Devicetree is supposed to describe hardware, in this case the quirks are a property
of the specific model of the hardware, so this should be expressed through the
compatible string. Extra properties in devicetree are meant to be used for board
specific things, like having a gpio to enable power to the sata target device.
Extra properties should not be used in the way you are proposing to use them now.

Regards,

Hans

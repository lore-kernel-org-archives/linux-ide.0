From: Loc Ho <lho@apm.com>
Subject: Re: [PATCH v3 3/4] ata: Add APM X-Gene SoC SATA host controller driver
Date: Tue, 26 Nov 2013 21:58:28 -0800
Message-ID: <CAPw-ZTk2+ZVjBn7hhJn=7JTuKP2SDuqJazaddAdr53PC84Y5Gw@mail.gmail.com>
References: <1384465153-29902-1-git-send-email-lho@apm.com>
	<1384465153-29902-3-git-send-email-lho@apm.com>
	<1384465153-29902-4-git-send-email-lho@apm.com>
	<201311151448.16279.arnd@arndb.de>
	<CAPw-ZTmaz3nnV3ThRgecT_RaYYW0bmfWvL8Kr-S3z1aKyUWc+w@mail.gmail.com>
	<CAPw-ZTn1N7+EFu9L6U+P9=9ii3k1BjycYXdNCdxCVPb8SaJWxA@mail.gmail.com>
	<529473DD.1090804@ti.com>
	<CAPw-ZTmPgYA+saJPVvB17VOPouDGvR0rd0nrZWi0j3zE7cc2rg@mail.gmail.com>
	<529588B5.1070109@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:38699 "HELO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751216Ab3K0F6a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Nov 2013 00:58:30 -0500
Received: by mail-pd0-f171.google.com with SMTP id z10so9205452pdj.2
        for <linux-ide@vger.kernel.org>; Tue, 26 Nov 2013 21:58:29 -0800 (PST)
In-Reply-To: <529588B5.1070109@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Tejun Heo <tj@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jon Masters <jcm@redhat.com>, Tuan Phan <tphan@apm.com>, Suman Tripathi <stripathi@apm.com>

Hi,

>>>> int set_speed(struct *phy, int lane, u64 speed);
>>>
>>> it should be phy_set_speed.
>> [Loc Ho]
>> But your other functions don't repeat the prefix "phy"?
>
> refer include/linux/phy/phy.h..
>
> int phy_init(struct phy *phy);
> int phy_exit(struct phy *phy);
> int phy_power_on(struct phy *phy);
> int phy_power_off(struct phy *phy);
[Loc Ho]
For the top level function, it is phy_set_speed. For the operation
function pointer, it is set_speed.

>>>>
>>>> where lane indicates the lane of the PHY and speed is the PHY speed in hertz.
>>>
>>> Does lane here means the number of lanes? Is the lane also obtained after the
>>> training sequence?
>> [Loc Ho]
>> Lane here is the lane with you are changing the speed. If there are
>> two lanes, then 0 parameter would change lane 0. 1 would change lane
>> 1.
>
> can different lanes operate at different speed at the same time?
>
[Loc Ho]
Yes. Each lane is suppose to be independent of each other.

-Loc

Return-Path: <SRS0=ghXF=AZ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390DCC433DF
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jul 2020 08:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E10921841
	for <linux-ide@archiver.kernel.org>; Tue, 14 Jul 2020 08:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hRaITEAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgGNITK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:19:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39642 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgGNITK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2020 04:19:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200714081907euoutp025eff9d77e35d18114cc8170581f69749~hkJ0juing1989619896euoutp02w
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2020 08:19:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200714081907euoutp025eff9d77e35d18114cc8170581f69749~hkJ0juing1989619896euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594714747;
        bh=3W48R5JZdOlotY4kDUq6GDCqsDBg3zDBeQZwRffH5cQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hRaITEABU3SBPZEGubCdXFsCDoUyWDD7rOB02/zLfRreB8ulARj898kR7N2NpM323
         A/10w0hCCieJgnIcQlR/VMZj7YUKvoT18f+6MheJsmIdX40Odqy42AvwQkKMHtsVxU
         NDTn9lADp4CDjKbIJWus38iTd1uKTHzKfluajA/E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200714081907eucas1p282d94245ef1c7790fa31b2383110eb27~hkJ0WjwWm2453224532eucas1p2T;
        Tue, 14 Jul 2020 08:19:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D2.29.06318.B7A6D0F5; Tue, 14
        Jul 2020 09:19:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200714081906eucas1p2da1533c2e4e8983bb42b20199dc1f977~hkJz17urA2902729027eucas1p2I;
        Tue, 14 Jul 2020 08:19:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200714081906eusmtrp1546fb7b152d27cdb0d5186fda9460044~hkJz1S4Oo2221422214eusmtrp10;
        Tue, 14 Jul 2020 08:19:06 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-4c-5f0d6a7b0c0a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.A4.06017.A7A6D0F5; Tue, 14
        Jul 2020 09:19:06 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200714081906eusmtip2f23c200b846080fe8f5e3023cef37df5~hkJzT_jxK0594905949eusmtip2X;
        Tue, 14 Jul 2020 08:19:06 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] drivers: ide: use generic power management
To:     Vaibhav Gupta <vaibhav.varodek@gmail.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <834eb293-bd4f-626c-4558-fbf71a5999f0@samsung.com>
Date:   Tue, 14 Jul 2020 10:19:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200714075247.GA4859@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXbv7q7LK4/T2Kkka9A7aWXIpUIqQuaX3ijSyGzlbZabxa6z
        rC+lsekQ1CyspWUyX0krMVtWFlOUnJlSiG5qokKmDiWN3pbmdpX89nvO+f+f/zlwaELWIl5O
        n0tK5nRJKo2CkpJ1zb/aN189z8RtGRtbylrSEtjrnzsRW/DhBsmOtlVRbLN1UMSahkZI9mN9
        AcW+zi8Vs9beTBFreTUh3i1V1lb0iJQvzH0SZVGNXlln6yKVNZWZlPJN4SOJ8s/PPKScqll5
        kD4u3RXPac6lcLrQiFPShJHqenRxaPXl8ZxJ8hrqXmZCPjTg7WCdzBeZkJSW4XIEPSUPkfCY
        RtBidFAelQxPIRjrWL/g6CvsnXeUIchyOQhB5EJw+1eqhwNwJLRVu0kPB+LNYGgwUh4Dgd+I
        wP20C3kaFN4BucZKLzM4Atx3Z71pJF4Dt2ayvbwUR8O3gUaxoPGHd3eHvZ/64BBwPP3i1RBY
        Do7hByKBg+G5q4DwhAHul4CpJE8sjL0PqiyDlMABMNpSKxE4COx5WaRgqEbwN2Nk3v0cQVne
        zLxjJ/S2/55jei5iAzyuDxXKe8Da1El6yoD9oNvlLwzhBzfr8gmhzECGQSao18KT0ifUQqzp
        RQWRgxTmRauZF61jXrSO+X9uESIrkZzT81o1x4clcZdCeJWW1yepQ85c0NagufOyz7R8t6IG
        92kbwjRS+DJwwDdOJlal8KlaGwKaUAQye9/bT8qYeFXqFU53IU6n13C8Da2gSYWcCSv+GivD
        alUyl8hxFzndQldE+yy/hsio0Y1tTK5huin2mPOM5qzTog2I2ZG76YdO1Kp5qQ78FG6UdhYP
        hO9fdfjjifTrz97Z+3lmnQylMZsae6LlvdsiO8TliTiKG7edLg82SCpnj6odfUtKf7e1y20d
        XHx7R8WdTqdvq4KauA87LxdONZiy+w+9jTlyL3FwOsiZriD5BNXWjYSOV/0DK4o4sFoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsVy+t/xe7pVWbzxBl+PGlssacqwaLx/kdFi
        zvkWFotXZ9ayWRzb8YjJouvxCxaLy7vmsFnsnb6M1WLHnU4miyV73rM6cHlsWXmTyWPnrLvs
        Hgs2lXpsO3SNxWPTqk42j/1z17B7/P4xmdHj8ya5AI4oPZui/NKSVIWM/OISW6VoQwsjPUNL
        Cz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwX63YxFjxWrHgz4QNLA+MNyS5GTg4JAROJ
        u3PvMHUxcnEICSxllDjwugfI4QBKyEgcX18GUSMs8edaFxtEzWtGiTdfW9lBEsICbhJn1v1h
        AbFFBHQl2va1gxUxC+xnkng67x8zSEJI4CWjRNsDBRCbTcBKYmL7KkYQm1fATuLPzP9sIDaL
        gKrElH/9YLaoQITE4R2zoGoEJU7OfAK2gFNAT+LWxudgNcwC6hJ/5l1ihrDFJW49mc8EYctL
        bH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHRuu3Y
        zy07GLveBR9iFOBgVOLhlfDniRdiTSwrrsw9xCjBwawkwut09nScEG9KYmVValF+fFFpTmrx
        IUZToOcmMkuJJucDE0leSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5O
        qQbGvYt4i63iCxtUzJfocCrzuVyS+2C8duNVvzP2Wr+nPVumuVtG8O0F3g3Wn7Z2v1/4maO1
        2aA4RGJ+FiffhEU2Nysc23dlNbU8mhpo/YBlr1tkE/Mel+ioq99eGFbWHj29ne/W28U/Mk0v
        FApuOLfqXIOxXPyaM8+7tpXHlOzpkTe4FqpYW5GmxFKckWioxVxUnAgA/LvsgewCAAA=
X-CMS-MailID: 20200714081906eucas1p2da1533c2e4e8983bb42b20199dc1f977
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200714073256eucas1p13ebe9585c29b766e48506400ba91a8ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200714073256eucas1p13ebe9585c29b766e48506400ba91a8ed
References: <20200713173613.2095-1-vaibhavgupta40@gmail.com>
        <CGME20200714073256eucas1p13ebe9585c29b766e48506400ba91a8ed@eucas1p1.samsung.com>
        <3b26bfff-7a42-7bbe-2050-51fe1ce96d4e@samsung.com>
        <20200714075247.GA4859@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 7/14/20 9:52 AM, Vaibhav Gupta wrote:
> On Tue, Jul 14, 2020 at 09:32:56AM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>> Hi,
>>
>> On 7/13/20 7:36 PM, Vaibhav Gupta wrote:
>>> Linux Kernel Mentee: Remove Legacy Power Management.
>>>
>>> The purpose of this patch series is to remove legacy power management callbacks
>>> from ide drivers.
>>>
>>> The suspend() and resume() callbacks operations are still invoking
>>> pci_save/restore_state(), pci_set_power_state(), pci_enable/disable_state(),
>>> etc. and handling the power management themselves, which is not recommended.
>>>
>>> The conversion requires the removal of the those function calls and change the
>>> callback definition accordingly and make use of dev_pm_ops structure.
>>
>> IDE subsystem (drivers/ide/) is deprecated and has been superseded by libata
>> subsystem (drivers/ata/).
>>
>> libata drivers have the same issue so please concentrate on fixing them
>> first. Later (if desirable) changes can be back-ported to drivers/ide/.
>>
> Hello, (drivers/ide) and (drivers/ata) are the two major families, I am working
> on, for generic PM upgradation. I was bit unaware about priority, and also in
> the last, both ide and ata drivers have to be upgraded.

Well, drivers/ide/ is scheduled for removal in 2021
(it even prints the warning during initialization of
every host driver)..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>>> All patches are compile-tested only.
>>
>> This patchset needs (at least) some basic testing. It should be easier with
>> libata subsystem as it also support SATA controllers and devices.
> To upgrade PM in (drivers/ide) I have made .suspend() and .resume() static. Then
> bind them in "struct dev_pm_ops" variable (ide_pci_pm_ops) and expose it using
> EXPORT_SYMBOL_GPL(). This has affected 30 drivers. I was hoping if ide changes
> can be tested/verified, specially [PATCH 1/3]. As then, I will be sure about
> similar change in ata, as it also requires similar alteration.
> 
> Thanks
> Vaibhav Gupta
> 
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>>> v3:
>>>     - Modpost error for undefined reference by Kbuild in v1.
>>>     - Another approach to disable PM in drivers/ide/triflex.c suggested by
>>>       Bjorn Helgaas in v2.
>>>
>>> Test tools:
>>>     - Compiler: gcc (GCC) 10.1.0
>>>     - allmodconfig build: make -j$(nproc) W=1 all
>>>
>>> Vaibhav Gupta (3):
>>>   ide: use generic power management
>>>   ide: sc1200: use generic power management
>>>   ide: delkin_cb: use generic power management
>>>
>>>  drivers/ide/aec62xx.c         |  3 +--
>>>  drivers/ide/alim15x3.c        |  3 +--
>>>  drivers/ide/amd74xx.c         |  3 +--
>>>  drivers/ide/atiixp.c          |  3 +--
>>>  drivers/ide/cmd64x.c          |  3 +--
>>>  drivers/ide/cs5520.c          |  3 +--
>>>  drivers/ide/cs5530.c          |  3 +--
>>>  drivers/ide/cs5535.c          |  3 +--
>>>  drivers/ide/cs5536.c          |  3 +--
>>>  drivers/ide/cy82c693.c        |  3 +--
>>>  drivers/ide/delkin_cb.c       | 32 +++++---------------------
>>>  drivers/ide/hpt366.c          |  3 +--
>>>  drivers/ide/ide-pci-generic.c |  3 +--
>>>  drivers/ide/it8172.c          |  3 +--
>>>  drivers/ide/it8213.c          |  3 +--
>>>  drivers/ide/it821x.c          |  3 +--
>>>  drivers/ide/jmicron.c         |  3 +--
>>>  drivers/ide/ns87415.c         |  3 +--
>>>  drivers/ide/opti621.c         |  3 +--
>>>  drivers/ide/pdc202xx_new.c    |  3 +--
>>>  drivers/ide/pdc202xx_old.c    |  3 +--
>>>  drivers/ide/piix.c            |  3 +--
>>>  drivers/ide/sc1200.c          | 43 ++++++++++++-----------------------
>>>  drivers/ide/serverworks.c     |  3 +--
>>>  drivers/ide/setup-pci.c       | 29 +++++------------------
>>>  drivers/ide/siimage.c         |  3 +--
>>>  drivers/ide/sis5513.c         |  3 +--
>>>  drivers/ide/sl82c105.c        |  3 +--
>>>  drivers/ide/slc90e66.c        |  3 +--
>>>  drivers/ide/triflex.c         | 24 +++++++------------
>>>  drivers/ide/via82cxxx.c       |  3 +--
>>>  include/linux/ide.h           |  8 +------
>>>  32 files changed, 62 insertions(+), 155 deletions(-)
>>>
>>
> 
> 


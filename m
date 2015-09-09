From: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] ahci: added a new driver for supporting Freescale AHCI sata
Date: Wed, 9 Sep 2015 18:14:55 -0500
Message-ID: <CADRPPNT+QYqcPVaPSdKcFJg1X5hULnmEJAaAjTuFad58B6aTJA@mail.gmail.com>
References: <1441160730-28006-1-git-send-email-Yuantian.Tang@freescale.com>
	<55E6B3E8.80902@redhat.com>
	<DM2PR03MB574DBC10E59CE7A8D10310DFA550@DM2PR03MB574.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DM2PR03MB574DBC10E59CE7A8D10310DFA550@DM2PR03MB574.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuantian Tang <Yuantian.Tang@freescale.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "tj@kernel.org" <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Sep 6, 2015 at 12:39 AM, Yuantian Tang
<Yuantian.Tang@freescale.com> wrote:
> Hi,
>
{snip}
>>
>> This will break booting new kernels with old dtb files, something which in
>> general is considered a big non-no, I suggest adding a comment that this has
>> been superseded by the new ahci_qoriq.c code, and maybe add a date to
>> retire the compatible in say a year from now.
>>
> There is no old dtb because LS* platforms are not been upstreamed yet.
> So I think we can safely replace it without breaking anything.

Please make sure all the internal development trees are updated
complying to this new binding.

Regards,
Leo

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 00/14] ata: ahci-platform: add reset control support except for existing drivers
Date: Wed, 22 Aug 2018 19:06:14 +0900
Message-ID: <20180822190614.974F.4A936039@socionext.com>
References: <1534923430-9692-1-git-send-email-hayashi.kunihiko@socionext.com> <cd35711a-5308-519d-7064-b82220a36d57@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cd35711a-5308-519d-7064-b82220a36d57@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Hans,

Thank you for your comment.

On Wed, 22 Aug 2018 11:27:18 +0200 <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 22-08-18 09:36, Kunihiko Hayashi wrote:
> > Add support to get and control a list of resets for the device, and
> > add the flag indicating whether to use the reset. Existing drivers
> > set 0 to this flags.
> > > This series solves the issue of the previous patch [1] that was already
> > reverted [2].
> > [1] https://www.spinics.net/lists/linux-ide/msg55299.html
> > [2] https://www.spinics.net/lists/linux-ide/msg55379.html
> > > Kunihiko Hayashi (14):
> >    ata: ahci-platform: add reset control support and the flag to specify
> >      using reset
> >    ata: ahci_brcm: add second argument of ahci_platform_get_resources()
> >    ata: ahci_ceva: add second argument of ahci_platform_get_resources()
> >    ata: ahci_da850: add second argument of ahci_platform_get_resources()
> >    ata: ahci_dm816: add second argument of ahci_platform_get_resources()
> >    ata: ahci_imx: add second argument of ahci_platform_get_resources()
> >    ata: ahci_brcm: add second argument of ahci_platform_get_resources()
> >    ata: ahci_mvebu: add second argument of ahci_platform_get_resources()
> >    ata: ahci_qoriq: add second argument of ahci_platform_get_resources()
> >    ata: ahci_seattle: add second argument of
> >      ahci_platform_get_resources()
> >    ata: ahci_st: add second argument of ahci_platform_get_resources()
> >    ata: ahci_sunxi: add second argument of ahci_platform_get_resources()
> >    ata: ahci_tegra: add second argument of ahci_platform_get_resources()
> >    ata: ahci_xgene: add second argument of ahci_platform_get_resources()
> 
> When you change a function prototype, you must also change all
> the callers in a single commit, so that all intermediate commits
> will compile without errors, otherwise you will break git bisect.

Surely, these splitted patches will make git bisect fail.
I'll collect them in a single commit.

> Otherwise this looks good.
> 
> I suggest you split this like this:
> 
> 1) Add a flags argument to ahci_platform_get_resources(),
>     without adding support for any flags yet, so this just
>     changes the function prototype and passes 0 for the new
>     flags argument *everywhere* without any other changes
> 2) Add support for a AHCI_PLATFORM_GET_RESETS flag, basically
>     your current first patch, minus the prototype patches
> 3) A patch which passes AHCI_PLATFORM_GET_RESETS for the
>     generic ahci_platform driver (so break this out of your
>     first patch). Also describe in the commit message of this
>     patch why / for which platforms this is necessary.
> 
> The idea of doing 3. separately is that we can easily revert
> it in case of problems while keeping the core functionality
> in place. Note I do not expect this to be necessary.

Your split plan will be very useful for bisecting. I'll try it next.

---
Best Regards,
Kunihiko Hayashi

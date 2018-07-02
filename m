From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Disable LPM on Lenovo 50 series laptops with a too
 old BIOS
Date: Mon, 2 Jul 2018 07:55:00 -0700
Message-ID: <20180702145500.GC533219@devbig577.frc2.facebook.com>
References: <20180701101546.10319-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180701101546.10319-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Jul 01, 2018 at 12:15:46PM +0200, Hans de Goede wrote:
> There have been several reports of LPM related hard freezes about once
> a day on multiple Lenovo 50 series models. Strange enough these reports
> where not disk model specific as LPM issues usually are and some users
> with the exact same disk + laptop where seeing them while other users
> where not seeing these issues.
> 
> It turns out that enabling LPM triggers a firmware bug somewhere, which
> has been fixed in later BIOS versions.
> 
> This commit adds a new ahci_broken_lpm() function and a new ATA_FLAG_NO_LPM
> for dealing with this.
> 
> The ahci_broken_lpm() function contains DMI match info for the 4 models
> which are known to be affected by this and the DMI BIOS date field for
> known good BIOS versions. If the BIOS date is older then the one in the
> table LPM will be disabled and a warning will be printed.
> 
> Note the BIOS dates are for known good versions, some older versions may
> work too, but we don't know for sure, the table is using dates from BIOS
> versions for which users have confirmed that upgrading to that version
> makes the problem go away.
> 
> Unfortunately I've been unable to get hold of the reporter who reported
> that BIOS version 2.35 fixed the problems on the W541 for him. I've been
> able to verify the DMI_SYS_VENDOR and DMI_PRODUCT_VERSION from an older
> dmidecode, but I don't know the exact BIOS date as reported in the DMI.
> Lenovo keeps a changelog with dates in their release notes, but the
> dates there are the release dates not the build dates which are in DMI.
> So I've chosen to set the date to which we compare to one day past the
> release date of the 2.34 BIOS. I plan to fix this with a follow up
> commit once I've the necessary info.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.18-fixes.

Thanks.

-- 
tejun

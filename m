From: Youquan Song <youquan.song@linux.intel.com>
Subject: Re: [PATCH v2] ata: Fix DVD not dectected at some Haswell platforms
Date: Mon, 18 Feb 2013 11:07:23 -0500
Message-ID: <20130218160723.GA1749@linux-youquan.bj.intel.com>
References: <1359731982-1390-1-git-send-email-youquan.song@intel.com> <20130213083242.GD1106@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130213083242.GD1106@fm.suse.cz>
Sender: stable-owner@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>
Cc: Youquan Song <youquan.song@intel.com>, htejun@gmail.com, ming.lei@canonical.com, sshtylyov@mvista.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, seth.heasley@intel.com, jlee@suse.com, james.d.ralston@intel.com, stable@vger.kernel.org, Youquan Song <youquan.song@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

> 
> As to my understanding Sergei did not suggest citing the whole commit message.
> I also find the numerous references to Sandy Bridge confusing as this is a fix
> for Lynx Point chipset.
> 
> How about rephrasing the commit message in a way similar to the following one?
> ------8<-----
> We've hit a problem with DVD not recognized on Haswell Desktop platform which
> includes Lynx Point 2-port SATA controller.  This quirk patch disables 32bit
> PIO on the controller in IDE mode.
> ------>8-----
Thanks Libor!
I have updated the comments and sent out a v3 patch out to LKML. 


> > +		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR | PIIX_FLAG_PIO16,
> 
> The line might be worth splitting as it's over 80 characters.
> 
> Otherwise the patch looks OK to me.
> 
Also change it in v3 patch.

Thanks
-Youquan

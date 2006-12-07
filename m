From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.19] sata_promise: cleanups, take 2
Date: Thu, 07 Dec 2006 07:21:41 -0500
Message-ID: <45780755.3040404@garzik.org>
References: <200612060855.kB68th9a024699@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1032123AbWLGMVp@vger.kernel.org>
In-Reply-To: <200612060855.kB68th9a024699@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> This patch performs two simple cleanups of sata_promise.
> 
> * Remove board_20771 and map device id 0x3577 to board_2057x.
>   After the recent corrections for SATAII chips, board_20771 and
>   board_2057x were equivalent in the driver.
> 
> * Remove hp->hotplug_offset and use hp->flags & PDC_FLAG_GEN_II
>   to compute hotplug_offset in pdc_host_init(). hp->hotplug_offset
>   was used to distinguish 1st and 2nd generation chips in one
>   particular case, but now we have that information in a more
>   general form in hp->flags, so hp->hotplug_offset is redundant.
> 
> Changes since previous submission: rebased on libata-dev #upstream,
> cleaned up hotplug_offset computation based on Tejun's comments,
> expanded hotplug_offset removal rationale.
> 
> This patch does not depend on the pending new EH conversion patch.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

applied

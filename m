From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] libata: Drop SanDisk SD7UB3Q*G1001 NOLPM quirk
Date: Thu, 31 May 2018 08:48:54 -0700
Message-ID: <20180531154854.GT1351649@devbig577.frc2.facebook.com>
References: <20180531112107.13778-1-hdegoede@redhat.com>
 <20180531121038.GR1455@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180531121038.GR1455@redhat.com>
Sender: stable-owner@vger.kernel.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Lorenzo Dalrio <lorenzo.dalrio@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Thu, May 31, 2018 at 01:10:38PM +0100, Richard W.M. Jones wrote:
> On Thu, May 31, 2018 at 01:21:07PM +0200, Hans de Goede wrote:
> > Commit 184add2ca23c ("libata: Apply NOLPM quirk for SanDisk
> > SD7UB3Q*G1001 SSDs") disabled LPM for SanDisk SD7UB3Q*G1001 SSDs.
> > 
> > This has lead to several reports of users of that SSD where LPM
> > was working fine and who know have a significantly increased idle
> > power consumption on their laptops.
> > 
> > Likely there is another problem on the T450s from the original
> > reporter which gets exposed by the uncore reaching deeper sleep
> > states (higher PC-states) due to LPM being enabled. The problem as
> > reported, a hardfreeze about once a day, already did not sound like
> > it would be caused by LPM and the reports of the SSD working fine
> > confirm this. The original reporter is ok with dropping the quirk.
> > 
> > A X250 user has reported the same hard freeze problem and for him
> > the problem went away after unrelated updates, I suspect some GPU
> > driver stack changes fixed things.
> > 
> > TL;DR: The original reporters problem were triggered by LPM but not
> > an LPM issue, so drop the quirk for the SSD in question.
> 
> As the reporter of the original issue, I agree with Hans's
> analysis above, so ACK from me.

I'm not sure this is related but we were seeing periodic complete
lockups on "SanDisk SD[78]SN*G" devices with NCQ enabled and
blacklisted them for NCQ recently.

Thanks.

-- 
tejun

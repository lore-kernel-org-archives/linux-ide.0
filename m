From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v5 2/2] Add support for SCT Write Same
Date: Wed, 10 Aug 2016 16:50:50 +0000
Message-ID: <CAGnHSE=EnhLwzfuu4wY=WbsA4PJ5tNfwBqErjLL10ea8d3EiGg@mail.gmail.com>
References: <1470790829-3793-1-git-send-email-shaun@tancheff.com>
 <1470790829-3793-3-git-send-email-shaun@tancheff.com> <CAGnHSEkJtUH6BkLoNB7v1DkF8ffaUf3RX+m=QzMU0-OmG0ZwFw@mail.gmail.com>
 <CAGnHSEkQXN5+6_OLQZEREWp1+W8kn8=ew=oH52oSsV7CaZwOBQ@mail.gmail.com> <CAJVOszAQZ_ukCkdBkkn5_iEPUCQKLBF=o-o0v+U=cWiOgQNSRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJVOszAQZ_ukCkdBkkn5_iEPUCQKLBF=o-o0v+U=cWiOgQNSRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Josh Bingaman <josh.bingaman@seagate.com>
List-Id: linux-ide@vger.kernel.org

On 10 August 2016 at 14:34, Shaun Tancheff <shaun.tancheff@seagate.com> wrote:
>
> You are correct in that we can advertise the larger limit in
> ata_scsi_dev_config() when only SCT write same is supported
> rather than fall back to WS10.

ata_scsi_dev_config()? Not sure if I follow. We should only need to
report Maximum Write Same Length in the Block Limit VPD
(ata_scsiop_inq_b0).

>
> TRIM is bound by an interface maximum. You can only stuff 64 entries
> of a 16 bit length followed by 48 bit lba into a 512 byte block.

Well that is actually the minimum. Modern SSDs often support more than
one-block payload (e.g. 8, 16...).  It's just our SCSI disk driver
statically limit it to the minimum. Though it allows only 0xffffffff /
512 = 8388607 (SD_MAX_WS16_BLOCKS) blocks per WRITE SAME (16) command
anyway, so we can at most allow only a 2-block (well, or 3-block)
payload.

>
> SCT is not restricted (you can wipe an entire drive) however there
> is a practical limit in that I have coded the SCT to operate
> in the foreground so the command could timeout depending
> on how fast the media can write.
>
> On my machine the default timeout is 30s so to clear 4194240 (16G):

You are talking about an AF 4Kn drive I suppose? For a 512e drive it
should be only ~2G.

>   30s -> 547 MB/s
>   60s -> 274 MB/s
>   90s -> 183 MB/s
> 120s -> 137 MB/s
>
> So for my drives 8G and 30s or 16G and 60s is fine.
> For older or slow drives 4G and 30s should be fine.
>
> I really am not sure what would be considered the correct
> solution though. I believe that the WRITE SAME defaults
> are currently being chosen around physical limits.

Not sure about what WRITE SAME defaults and physical limits you are
referring to.

>
> We could reduce the trim to 16 entries when SCT is available and
> bump SCT to the same 16 * 63335 maximum?

I am not sure if that's a good idea. Small TRIM payloads (hence more
TRIM commands) could lead to noticeable overhead in my experience. But
if 4194240 blocks is really too many for SCT Write Same in any case, I
guess we will have to compromise, since the Maximum Write Same Length
field is shared. (Now it feels unfortunate that we decided to switch
from UNMAP -> TRIM to WRITE SAME (16) -> TRIM long ago.) The question
is, do we want the value to stay at 4194240 when SCT Write Same is not
available?

I have no idea what the value should be. But, given the fact sector
size seems to matter much in the SCT case, perhaps at the very least,
we would want to derive the multiplier from that?

>
> I think we can also bump the command timeout for WRITE SAME?

I have no idea where the timeout comes from. Is it even a thing in the
kernel (instead of one in the firmware of the drive or the ACS
standard)?

>
> Suggestions are welcome.
> --
> Shaun Tancheff

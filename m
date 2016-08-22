From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH v6 3/4] SCT Write Same / DSM Trim
Date: Mon, 22 Aug 2016 20:57:52 +0000
Message-ID: <CAGnHSEn64mQt=ujSRCN_1pfzHXSDqe=esvZZ1mv-3oPxNZMFLQ@mail.gmail.com>
References: <20160822042321.24367-1-shaun@tancheff.com> <20160822042321.24367-4-shaun@tancheff.com>
 <CAGnHSEn95Z8wKfq1Nf0ntKSzze-ScP5WeAahziD5Sk0QfmEXyw@mail.gmail.com>
 <CAGnHSEmFMx1Q6mRV-hXwR4_08OvvSR1xcxoT1dLjVMvOHYY_+g@mail.gmail.com>
 <CAJVOszCvXwjJCEwxOG0GhN9wq+Axq15zW7Ja=EybyZLRZBYkpA@mail.gmail.com>
 <CAGnHSE=-kqLyQQ4dZ1=VQ=iBectjHmbF7wg_bxUJ_k+H6nq8bA@mail.gmail.com>
 <CAJVOszCjjjx39GsdFtKAdwVRG0dJ0Frf4MKSQVHorA_qSZzR7w@mail.gmail.com> <CAGnHSEkOm3nmmeHMQ5Jok2v2Up3ygNE5AE0sjkFTY26_4PTKvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGnHSEkOm3nmmeHMQ5Jok2v2Up3ygNE5AE0sjkFTY26_4PTKvg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaun Tancheff <shaun.tancheff@seagate.com>
Cc: Shaun Tancheff <shaun@tancheff.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>, Damien Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.de>, Josh Bingaman <josh.bingaman@seagate.com>, Hannes Reinecke <hare@suse.com>
List-Id: linux-ide@vger.kernel.org

On 22 August 2016 at 18:52, Tom Yan <tom.ty89@gmail.com> wrote:
>
> For the "payload block size" that is "always" 512-byte as per the same
> spec, I don't think we need to concern about it. I think it only
> matters if we want to enable multi-block TRIM payload according to the
> reported limit in IDENTIFY DEVICE data. Probably it merely means that
> the "each of the blocks" in the reported limit will always mean 64
> TRIM entries, even on 4Kn drives, instead of 512.
>

Actually that's what we assumed in our current code that forms the DSM
command as well. See how (hob_)feature for queued TRIM and how
(hob_)nsect for non-queued TRIM are set in ata_scsi_write_same_xlat in
libata-scsi ('size / 512').

So if you are going to increase the payload block size per logical
sector size (in other word, you assume that the payload block size is
_expected_ to be the logical block size, in spite of what ACS told,
you'll need to adjust how the aforementioned fields in the ATA
taskfile are set as well.

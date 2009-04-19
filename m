From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 12/15] ide-cd: convert to using generic sense request
Date: Sun, 19 Apr 2009 18:28:24 +0900
Message-ID: <49EAEEB8.10300@kernel.org>
References: <1239960802-31978-1-git-send-email-tj@kernel.org> <1239960802-31978-13-git-send-email-tj@kernel.org> <20090419092254.GB2906@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57687 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbZDSJ2d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Apr 2009 05:28:33 -0400
In-Reply-To: <20090419092254.GB2906@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Borislav Petkov wrote:
>> +			/*
>> +			 * Sense is always read into drive->sense_data.
>> +			 * Copy back if the failed request has its
>> +			 * sense pointer set.
>> +			 */
>> +			memcpy(failed->sense, sense, 18);
>=20
> shouldn't this line be:
>=20
> 			memcpy(failed->sense, sense, rq->sense);
>=20
> ?
>=20
> According to SFF8020i, Section 10.8.20 REQUEST SENSE Command, the sen=
se
> length can be > 18:

It doesn't really matter in this patch.  This patch shouldn't change
what number of bytes are considered by ide-cd for sense data.  Before
the patch it was 18, so it should remain 18 after the patch.

> "ATAPI CD-ROM Drives shall be capable of returning at least 18 bytes =
of
> data in response to a REQUEST SENSE command. (...)
>=20
> Host Computers can determine how much sense data has been returned by
> examining the allocation length parameter in the Command Packet and t=
he
> additional sense length in the sense data. ATAPI CD-ROM Drives shall
> not adjust the additional sense length to re=EF=AC=82ect truncation i=
f the
> allocation length is less than the sense data available."
>=20
> So, a possible scenario might be:
>=20
> We issue a REQUEST_SENSE to a device and it returns more than 18 byte=
s
> of sense data which should normally fit in the request_sense buffer b=
ut
> we only copyback the first 18 bytes. Now, the error handling doesn't
> touch any members behind the 18th byte (sense->asb) but we still subt=
ly
> carry stale data with us resulting in future bugs if one decides to
> touch the additional sense bytes (->asb).
>=20
> However, is there any reason for copying back the sense bytes at all?
> In other words, does the block layer code need sense data when ending=
 a
> request or is it used only by LLDDs for error handling? Because if I'=
m
> not missing something, we could just as well use the drive->sense_dat=
a
> in the failed->sense case and thus alleviate the need for the copy.
> ide_cd_complete_failed_rq is called on the IRQ path so drive->sense_d=
ata
> has to be still valid for the current request is a sense request, no?
>=20
> As a result and if I'm reading the code correctly, we could simply do
> (pasting the whole function instead of a diff for more clarity) :
>=20
> static void ide_cd_complete_failed_rq(ide_drive_t *drive, struct requ=
est *rq)
> {
>         /*
>          * For REQ_TYPE_SENSE, "rq->special" points to the original
>          * failed request
>          */
>         struct request *failed =3D (struct request *)rq->special;
>         struct request_sense *sense =3D &drive->sense_data;
>=20
>         if (failed) {
>                 if (failed->sense)
>                         /* Sense is always read into drive->sense_dat=
a. */
>                         failed->sense_len =3D rq->sense_len;
>=20
>                 cdrom_analyze_sense_data(drive, failed, sense);
>=20
>                 if (ide_end_rq(drive, failed, -EIO, blk_rq_bytes(fail=
ed)))
>                         BUG();
>         } else
>                 cdrom_analyze_sense_data(drive, NULL, sense);
> }

So, please feel free to submit a separate patch for this.  :-)

Thanks.

--=20
tejun

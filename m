From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH] IDE-TAPE NULL terminate strings.
Date: Mon, 22 Sep 2008 15:56:49 +0200
Message-ID: <9ea470500809220656j6dfcf4c9q7a5a4185481ec994@mail.gmail.com>
References: <20080921185138.GA16310@localhost> <48D79ABD.8060805@ru.mvista.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.186]:31850 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbYIVN4v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 09:56:51 -0400
Received: by rn-out-0910.google.com with SMTP id k40so460696rnd.17
        for <linux-ide@vger.kernel.org>; Mon, 22 Sep 2008 06:56:49 -0700 (PDT)
In-Reply-To: <48D79ABD.8060805@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mark de Wever <koraq@xs4all.nl>, Gadi Oxman <gadio@netvision.net.il>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 22, 2008 at 3:16 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Mark de Wever wrote:
>
>> After updating my kernel to 2.6.26 the output for the ide-tape drive
>> during booting is garbled eg
>> ide-tape: hdd <-> ht0: Seagate <98>=DF8A51|1=C0<81>=DC=BA<98>=DF STT=
20000A rev
>> 8A51|1=C0<81>=DC=BA<98>=DF
>
>> This patch fixes the problem by NULL terminating the strings.
>
>   Looks like this bugs was introduced by this commit:
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D41f81d545b6b1f585a02d1d8545978714f710e91

=2E. and I know why :). Those ide_tape_obj members (char fw_rev[6], ven=
dor_id[10],
product_id[18]) were used only once in idetape_get_inquiry_results() so=
 I moved
them there as local stack variables. Originally, they were kzalloc'ed a=
s part of
struct ide_tape_obj and now they contain stack garbage therefore the fu=
nny
values. The simple solution would be to zero them out or:


Does the following patch help?

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 1bce84b..848d9df 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2338,7 +2338,7 @@ static void
idetape_get_inquiry_results(ide_drive_t *drive)
 {
 	idetape_tape_t *tape =3D drive->driver_data;
 	struct ide_atapi_pc pc;
-	char fw_rev[6], vendor_id[10], product_id[18];
+	static char fw_rev[6], vendor_id[10], product_id[18];

 	idetape_create_inquiry_cmd(&pc);
 	if (idetape_queue_pc_tail(drive, &pc)) {


--=20
Regards/Gruss,
Boris

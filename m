From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] IDE-TAPE NULL terminate strings.
Date: Mon, 22 Sep 2008 00:08:27 +0400
Message-ID: <48D6A9BB.1070705@ru.mvista.com>
References: <20080921185138.GA16310@localhost> <48D69F5A.9010201@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:58373 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751462AbYIUUH2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Sep 2008 16:07:28 -0400
In-Reply-To: <48D69F5A.9010201@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark de Wever <koraq@xs4all.nl>
Cc: Gadi Oxman <gadio@netvision.net.il>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

>> After updating my kernel to 2.6.26 the output for the ide-tape drive
>> during booting is garbled eg
>> ide-tape: hdd <-> ht0: Seagate <98>=DF8A51|1=C0<81>=DC=BA<98>=DF STT=
20000A rev=20
>> 8A51|1=C0<81>=DC=BA<98>=DF

>> This patch fixes the problem by NULL terminating the strings.

>> Regards,
>> Mark de Wever

>> PS: please CC me since I'm not subscribed.
>> PPS: there are more problems with my tapestreamer in 2.6.26 but I'll
>> post a separate message for that.

>> Signed-off-by: Mark de Wever <koraq@xs4all.nl>

>> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
>> index 1bce84b..fd87b43 100644
>> --- a/drivers/ide/ide-tape.c
>> +++ b/drivers/ide/ide-tape.c
>> @@ -2354,6 +2354,10 @@ static void=20
>> idetape_get_inquiry_results(ide_drive_t *drive)
>>      ide_fixstring(product_id, 18, 0);
>>      ide_fixstring(fw_rev, 6, 0);

    Hm, I see that every string variable declared there has 2 extra=20
characters, and yet the author have managed to make a mistake... these =
extra=20
chars don't seem needed.

MBR, Sergei

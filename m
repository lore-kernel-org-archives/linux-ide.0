From: Thomas Jackowski <aXe@hadiko.de>
Subject: Re: Errors on ICH10R with Seagate HDDs
Date: Mon, 29 Jun 2009 10:17:55 +0200
Message-ID: <4A4878B3.9020206@hadiko.de>
References: <49D4A232.3090504@hadiko.de> <49DE39E2.7070505@kernel.org> <49E847A3.9070100@hadiko.de> <49EAE746.4040303@kernel.org> <49F2E47C.5010803@hadiko.de> <49F3C03C.1090803@kernel.org> <4A36FC7D.5050805@hadiko.de> <4A388E1F.5070404@kernel.org> <4A3FD015.4090602@hadiko.de> <4A443366.4010807@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.rz.uni-karlsruhe.de ([129.13.185.217]:33848 "EHLO
	smtp1.rz.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480AbZF2IRy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jun 2009 04:17:54 -0400
Received: from postamt.hadiko.de ([2001:638:204:10:21b:21ff:fe22:d9c2])
	by jordan.hadiko.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <aXe@hadiko.de>)
	id 1MLC3o-0004BS-C8
	for linux-ide@vger.kernel.org; Mon, 29 Jun 2009 10:17:56 +0200
In-Reply-To: <4A443366.4010807@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

there is no relevant output in this loop (running about 6 hours).

Tejun Heo wrote:
> Thomas Jackowski wrote:
>> Hi,
>>
>> I have no clue where this command comes from. How can I determine th=
is?
>>
>> I'm not using disk head parking.
>=20
> Hmmm.... busy looping fuser -v /dev/sdX would probably catch it given
> enough time.  Can you please run "while true; do fuser -v /dev/sdX;
> done" for a while and report the result?  If it doesn't give you
> anything, please let me know, I'll prep a debug patch.
>=20
> Thanks.
>=20

--=20
Gru=DF,
Thomas

From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Tue, 5 Oct 2010 19:00:41 -0600
Message-ID: <AANLkTin=QWXcuy6JOi1y26dWH8FG1ji3JewTXu0K=4ri@mail.gmail.com>
References: <4C9C3878.9010206@teksavvy.com>
	<AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com>
	<4C9C44D0.1030409@teksavvy.com>
	<AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com>
	<4C9CA385.5090709@teksavvy.com>
	<4C9CA673.4090104@teksavvy.com>
	<4C9D33C0.8050900@gmail.com>
	<4CA99BCB.8080904@gmail.com>
	<4CAA0885.8060906@teksavvy.com>
	<4CAA0996.5080403@teksavvy.com>
	<4CAA0F6C.6080609@teksavvy.com>
	<4CAA21F4.5060000@teksavvy.com>
	<4CAA2AA6.2010204@pobox.com>
	<4CAA2C6F.2090603@teksavvy.com>
	<4CAA2E16.4010905@pobox.com>
	<4CAA3033.8030405@teksavvy.com>
	<4CAACEBE.1000104@gmail.com>
	<4CAB30FA.2010508@teksavvy.com>
	<4CAB4CE9.9070709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38870 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978Ab0JFBAm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2010 21:00:42 -0400
Received: by ywh1 with SMTP id 1so238703ywh.19
        for <linux-ide@vger.kernel.org>; Tue, 05 Oct 2010 18:00:41 -0700 (PDT)
In-Reply-To: <4CAB4CE9.9070709@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, Jeff Garzik <jgarzik@pobox.com>, Seed <seedrubbish@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Tue, Oct 5, 2010 at 10:06 AM, Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> On 10/05/2010 04:06 PM, Mark Lord wrote:
>> Yeah, maybe something like that.
>>
>> But do note that I have verified that "hdparm -C" does work correctl=
y,
>> and is dependent upon correctly returned result_tf values.
>>
>> It's not a PIO "data" command, though. =A0Does it get issued the sam=
e way?
>
> PIO Setup FIS is not used for nodata commands. =A0IIRC, nodata uses D=
2H
> Reg FIS for command completion. =A0I think the only exception is PIO
> data commands. =A0The weird hack is to satisfy PIO data command proto=
col
> timing requirement stemming from PATA specification. =A0Eh... ugly.

=46rom my reading of the SATA spec, with the PIO data-in protocol, the
device can raise a D2H register FIS prior to transmitting data if the
command is aborted due to an error, but for normal completion, the
state machine just goes back to idle after the last data FIS is
transmitted and there's no final D2H register FIS - the final status
is set by the last PIO Setup FIS received. According to the AHCI spec,
the host adapter is supposed to copy the PIO Setup FIS to memory as
well. Presumably when retrieving the result taskfile for such PIO
data-in transfers we should be pulling it from that area, not the D2H
register FIS area, at least if the device transferred any data?

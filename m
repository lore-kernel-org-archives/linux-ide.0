From: "Moore, Eric" <Eric.Moore@lsi.com>
Subject: RE: ATA_16 support on mptsas
Date: Fri, 27 Jun 2008 09:07:55 -0600
Message-ID: <660360F4F2570145BD872F298951B17A299A769A@cosmail03.lsi.com>
References: <200806271624.19884.kb@sysmikro.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail0.lsil.com ([147.145.40.20]:57543 "EHLO mail0.lsil.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbYF0PIb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jun 2008 11:08:31 -0400
In-Reply-To: <200806271624.19884.kb@sysmikro.com.pl>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-2?Q?Krzysztof_B=B3aszkowski?= <kb@sysmikro.com.pl>
Cc: "jgarzik@pobox.com" <jgarzik@pobox.com>, "Stewart, Ken" <Ken.Stewart@lsi.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, DL-MPT Fusion Linux <DL-MPTFusionLinux@lsi.com>

On Friday, June 27, 2008 8:24 AM,  Krzysztof B=B3aszkowski wrote:
>
> The recent firmware for e.g. SAS3442 doesn't send check
> condition with ata
> registers file so some commands don't work properly although
> those commands
> don't return drive state are delivered to drive and processed
> by the drive.
>

I device driver supports returning sense data, so if the target returne=
d sense, it would be sent up the stack.    Here is the location of the =
SATL spec http://www.t10.org/ftp/t10/drafts/sat2/sat2r05.pdf, please re=
fer to section 11.1..   So can you provide more details on which comman=
ds are you expecting sense data on.    Meanwhile I will send Ken the mp=
t fusion engineering design note for SATL.

Eric

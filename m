From: Dongjun Shin <djshin90@gmail.com>
Subject: Re: [PATCH 4/5] ide: Add support for TRIM
Date: Wed, 8 Apr 2009 23:44:04 +0900
Message-ID: <7fe698080904080744y15f781b9lc71d84e705ef6089@mail.gmail.com>
References: <1238683047-13588-1-git-send-email-willy@linux.intel.com>
	 <1238683047-13588-2-git-send-email-willy@linux.intel.com>
	 <1238683047-13588-3-git-send-email-willy@linux.intel.com>
	 <1238683047-13588-4-git-send-email-willy@linux.intel.com>
	 <49DCB5A5.7040100@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:63234 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZDHOoF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2009 10:44:05 -0400
In-Reply-To: <49DCB5A5.7040100@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Matthew Wilcox <willy@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@redhat.com, David Woodhouse <David.Woodhouse@intel.com>

On Wed, Apr 8, 2009 at 11:33 PM, Mark Lord <liml@rtr.ca> wrote:
>
> Matthew Wilcox wrote:
>>
>> From: David Woodhouse <David.Woodhouse@intel.com>
>>
>> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
>> [modified to reduce amount of special casing needed for discard]
>> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
>> ---
>
> ..
>>
>> + =A0 =A0 =A0 task->tf.command =3D ATA_CMD_DSM;
>> + =A0 =A0 =A0 task->tf.feature =3D ATA_DSM_TRIM;
>> + =A0 =A0 =A0 task->tf.hob_feature =3D 0x00;
>> + =A0 =A0 =A0 task->tf.nsect =3D size / 512;
>> + =A0 =A0 =A0 task->tf.hob_nsect =3D (size / 512) >> 8;
>
> ..
>
> Matthew (or others),
>
> Could you perhaps explain what the purpose of the data portion
> of this command is for? =A0The draft ATA spec I have here has mangled
> text in the description -- like it's missing a crucial sentence there=
=2E
>
> So it's not obvious exactly why this command even needs data to
> be transfered.

It's for transfering list of LBA ranges which composed of
LBA offset (48bit) and length of data to be trimmed (16bit).

--
Dongjun

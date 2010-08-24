From: Tejun Heo <tj@kernel.org>
Subject: Re: Maybe a bug in libata-core
Date: Tue, 24 Aug 2010 09:27:57 +0200
Message-ID: <4C73747D.7090305@kernel.org>
References: <4C71C645.8050007@stud.tu-ilmenau.de> <4C723C65.6080303@kernel.org> <4C72F929.6090401@stud.tu-ilmenau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45029 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708Ab0HXHdd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Aug 2010 03:33:33 -0400
In-Reply-To: <4C72F929.6090401@stud.tu-ilmenau.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stefan.huebner@stud.tu-ilmenau.de
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello,

On 08/24/2010 12:41 AM, Stefan /*St0fF*/ H=FCbner wrote:
> As far as I know my code I thought I did send enough data.  Maybe I'm
> misunderstanding something: I valloc'ated block_count*logical_block_s=
ize
> bytes, filled them with data and presented this buffer to the
> sg_io_hdr_t structure by setting dxfer_len to the length of the buffe=
r,
> setting dxferp to a pointer to the buffer and setting the
> dxfer_direction to SG_DXFER_TO_DEV.
>=20
> The only thing coming to my mind would be overflow of dxfer_len, but =
as
> this is a unsigned int - wouldn't it be 32 bits wide? (and by that
> accepting f.e. 64k*512 bytes =3D 33 554 432 bytes (32M, needing 25 bi=
ts))
>=20
> Any other suggestions, or do I have to present the code?

Yeah, posting a simple test case would be the best way to proceed
here.

Thanks.

--=20
tejun

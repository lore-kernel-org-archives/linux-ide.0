Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC3F3CFF6F
	for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 19:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772699; cv=none; b=s7ZkZ55lMwtCIdtHpMHrhg50Gs9vn7jObyH4NwBPrumq63TVQDeN025XFeD6EumnJJ0zOGO2qwzJhTQk+tmgkFS9R8vfrZWnF85Mg4nrMvK2nAU1ilvOzx04AtBn2PXgyF6kqBgA2n8GhEQSaY2QgulLaAANVwVDIsfbf+FlX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772699; c=relaxed/simple;
	bh=SGfLYuzawYM7CArQUCVBEeD5eD6OckEYf0HNwbCiXAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLhZ2uXnD6/pF8M0GVe71sHRQwjEfE7uJs39ZjygPP1biijHHzNdd8WBfm5vXo11MLiPPSyPbVw0D406AFj0Dd/cHlYpClK1dhRHkNBMZXqNf1HABD3bOqa46f6qUN81HXrdcSyxb/5IOYp35A+tFr9rwCLJji1+GakIqRdYG30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTkQvk8W; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTkQvk8W"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so951149a12.2
        for <linux-ide@vger.kernel.org>; Wed, 26 Aug 2026 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787772689; x=1788377489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87q+5ivROSLtYuJS4l3dPY+myx5uTzr/xnq7BAcE3WU=;
        b=eTkQvk8WMa6mlDzcSyV11t0wN9va+X95JuON5Yg0VnIoWdT+OXtWRhY8Ov9dizgPbl
         C/sdl5KXw2vMPgE8vNIB42TIz0h6BGIojgFazpMx1qwFKT/2z1m3a8KiES7M8h3ohz+l
         gl53EBCR3gtRQdumbv8MCTfFubHY31ivSW7xmhRE4Fawaw0xMoiBOKJEHrVvhM8tmWCe
         AEHSNGKjKZaTFxDGTcvWeWG4fl8dHWSBEUy82gMRgizQwEo6xZYq4tyfPbrwGiNgQjYW
         bajbn5Aqdl1MCol/2ovKpm43TLiGcQOPttPURiXR+KLYdE8tEOwMMxVGucajnTRQGHXd
         cGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787772689; x=1788377489;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87q+5ivROSLtYuJS4l3dPY+myx5uTzr/xnq7BAcE3WU=;
        b=rOds/Yg55SSex9GCdfPQWB+5x2Ti+iJSnqU8rXE7WBwupJS6qnhJPnC1oRNCkV51pG
         oa3V/bZG7wJsluX0+5wPlWMOQTsCN8Zjwh0V3idWG84sYSKucXs/fRCA/ccN6x4//Pz9
         FWNMM/okAleK41Crz+/JCyU86uvU7NveTgV4dm4Wjxo1ADZhcLrXXfgrfIWdbmfLPp/k
         DA1N+dcVlTXPug268mwTnIML4fTHoWz58nbwtcRVyyjWJUjr8GpHCbjeUO4hdqMKmc7k
         NJWg+oEuKIO565uBAPlYc+09SitdE7XHtB+j/9JiRsEbN73ViuGqLlH1CatvY92+MWqU
         XN9Q==
X-Forwarded-Encrypted: i=1; AHgh+RrYBZeCISK8t7foDR88gNbTt1HjuYH194N+hEIRaqQUakKe/nXjKdA4wcl8MCnVh0q9rwDxXQvT3cs=@vger.kernel.org
X-Gm-Message-State: AFuF++mkItZ+hprGbtA57f8B78fwiEfcuESe1QYL8Zm0gx/0ln3NTLHJ
	gvx7/2ztCnkou8b9kfE7W+0ADcSdOkMhV5qdvPonAEAUxFuK/bCSHUPd
X-Gm-Gg: AR+sD13afLWWVHvjDGneA1xeSJz6K1ApSwcVzlJutc3Gz2ID1rF3yOL3VaeR9qLvnJO
	JHi9MExdLLwasHZNTbHzhdru/Ut9nWnW5XWvGuvlk1liYZThbhxhZyStxuzDem3RYUzAJm4PWaU
	Irpi6hOS01SHwEdzGcWPbxyC70q0McFK/Ci6+PdSMUWCt1SAtpgzLczm/DKjLFEnz1VFvjINxYL
	ETDm48naC4aGN/TcwCe5v1BtdB9Q52p8rHeX988oeDydelqcv6ANE17yJCE020C8EJRzVvdbeia
	NBA5Jv/VyO/SaUNfHRAUeq1nbk8I0IRs/7P94q2nrEhS2UylzwvpEGtgfajSAcVPtxC1que6mx4
	r7T2dvkdltJQSaDGePm8qN9QyvxCxZS4FLPod0EifwygqCMlB8NBb5ChIHuOO/IVsw+GAFKziz7
	1cuNCUTeug9Ri/AqIretXGl8g/UnuunWKz98OkedFu0ml9wly4CQjP8ZXIkunNEqkrVx48n7Zbr
	UhqXvVkfELgRf8nLsFCG8h6B9Ug/6LHKti+waqcTNPUaIn7SDTr3OxU3zy376Eadv1rX82YiFix
X-Received: by 2002:a17:90b:4b0f:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-3966d1d9579mr17435841a91.6.1787772688569;
        Wed, 26 Aug 2026 12:31:28 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:b984:9fe3:5dce:f291? ([2001:df0:0:200c:b984:9fe3:5dce:f291])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965547159asm7952454a91.12.2026.08.26.12.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 12:31:28 -0700 (PDT)
Message-ID: <b010c98c-ecd5-439c-b07d-3efad26de7f2@gmail.com>
Date: Thu, 27 Aug 2026 07:31:22 +1200
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] ata: pata_cswarp: Add Amiga cslab ata support
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Paolo Pisati <p.pisati@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org
References: <20260824153339.512487-1-p.pisati@gmail.com>
 <20260824153339.512487-2-p.pisati@gmail.com>
 <CAMuHMdVBjxXNX19k55Yu4D5GD1nkb31TuBJN0uFDqD9Oe5Gtsw@mail.gmail.com>
Content-Language: en-US
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdVBjxXNX19k55Yu4D5GD1nkb31TuBJN0uFDqD9Oe5Gtsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Geert,

On 25/08/26 19:53, Geert Uytterhoeven wrote:
>> +static unsigned int pata_cswarp_data_xfer(struct ata_queued_cmd *qc,
>> +                                         unsigned char *buf,
>> +                                         unsigned int buflen, int rw)
>> +{
>> +       struct ata_device *dev = qc->dev;
>> +       struct ata_port *ap = dev->link->ap;
>> +       void __iomem *data_addr = ap->ioaddr.data_addr;
>> +       unsigned int words = buflen >> 1;
>> +       u16 *buf16 = (u16 *)buf;
>> +
>> +       /* Transfer multiple of 2 bytes */
>> +       if (rw == READ)
>> +               raw_insw(data_addr, buf16, words);
>> +       else
>> +               raw_outsw(data_addr, buf16, words);
>> +
>> +       /* Transfer trailing byte, if any. */
>> +       if (unlikely(buflen & 0x01)) {
>> +               if (rw == READ)
>> +                       buf[buflen - 1] = raw_inw(data_addr) >> 8;
>> +               else
>> +                       raw_outw(buf[buflen - 1] << 8, data_addr);
>> +               words++;
>> +       }
>> +
>> +       return words << 1;
> This may be one less than the actual number of bytes
> Why not buflen?
>
words = buflen >> 1;

followed by

if (buflen & 0x01) words++;

makes 'words' the correct (i.e. rounded upwards if buflen was odd) 
number of words transferred.

The return value is then either correct, or one larger than the actual 
number of bytes?

I believe the template for these functions was 
drivers/ata/libata-sff.c:ata_sff_data_xfer() which follows the exact 
same logic.

Cheers,

MIchael

>> +}
>> +static int pata_cswarp_probe(struct zorro_dev *z,
>> +                            const struct zorro_device_id *ent)
>> +{
>> +       static const char board_name[] = "csWarp";
>> +       struct ata_host *host;
>> +       struct ata_port *ap;
>> +       void __iomem *base;
>> +       unsigned long board = z->resource.start;
>> +
>> +       dev_info(&z->dev, "%s IDE controller (board: 0x%lx)\n", board_name,
>> +                board);
>> +
>> +       if (!devm_request_mem_region(&z->dev, board + WARP_OFFSET_ATA, 0x1800,
>> +                                    DRV_NAME))
>> +               return -ENXIO;
>> +
>> +       host = ata_host_alloc(&z->dev, 1);
>> +       if (!host)
>> +               return -ENXIO;
>> +
>> +       ap = host->ports[0];
>> +       base = ioremap(board + WARP_OFFSET_ATA, 0x1800);
>> +
>> +       ap->ops = &pata_cswarp_ops;
>> +
>> +       ap->pio_mask = ATA_PIO4;
>> +       ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY |
>> +               ATA_FLAG_PIO_POLLING;
>> +
>> +       ap->ioaddr.data_addr            = base;
>> +       ap->ioaddr.error_addr           = base + 1 * 4;
>> +       ap->ioaddr.feature_addr         = base + 1 * 4;
>> +       ap->ioaddr.nsect_addr           = base + 2 * 4;
>> +       ap->ioaddr.lbal_addr            = base + 3 * 4;
>> +       ap->ioaddr.lbam_addr            = base + 4 * 4;
>> +       ap->ioaddr.lbah_addr            = base + 5 * 4;
>> +       ap->ioaddr.device_addr          = base + 6 * 4;
>> +       ap->ioaddr.status_addr          = base + 7 * 4;
>> +       ap->ioaddr.command_addr         = base + 7 * 4;
>> +
>> +       ap->ioaddr.altstatus_addr       = base + (0x1000 | (6UL << 2));
>> +       ap->ioaddr.ctl_addr             = base + (0x1000 | (6UL << 2));
>> +
>> +       ata_port_desc(ap, "  cmd 0x%lx ctl 0x%lx", (unsigned long)base,
>> +                     (unsigned long)ap->ioaddr.ctl_addr);
> Both printed addresses are virtual addresses hence not really useful.
> If you want to print something, please print board or z->resource
> instead.
>
>> +static const struct zorro_device_id pata_cswarp_zorro_tbl[] = {
>> +       { ZORRO_PROD_CSLAB_WARP_1260, 0},
>> +       { 0 }
> Please use named initializers, and drop unneeded zeroes, like Uwe
> just did in all existing Zorro drivers:
>
>      { .id = ZORRO_PROD_CSLAB_WARP_1260 },
>      { }
>
>> +};
> Gr{oetje,eeting}s,
>
>                          Geert
>

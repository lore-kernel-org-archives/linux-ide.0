From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: 2.6.26-git: ata_piix link is slow to respond regression.
Date: Thu, 8 May 2008 18:08:19 +0000 (UTC)
Message-ID: <fvvfij$u94$1@ger.gmane.org>
References: <1210267842.4175.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932915AbYEHSI5@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thu, 08 May 2008 19:30:42 +0200, Soeren Sonnenburg wrote:

> ata_piix 0000:00:1f.2 MAP [P0 P2 -- -- ] link is slow to respond, ple=
ase
> be patient =EF=BB=BF(ready=3D0) SRST failed =EF=BB=BF(errno=3D-1f)

The issue might be solved by the patch on=20
http://thread.gmane.org/gmane.linux.ide/31317/focus=3D31349 ...

--=20
Sitsofe | http://sucs.org/~sits/

From: Gentoopower <gentoopower@yahoo.de>
Subject: Re: problem mounting a partition on a usb drive
Date: Fri, 27 Jan 2006 13:58:46 +0100
Message-ID: <43DA1906.1060302@yahoo.de>
References: <7ac1e90c0601270433u3be68c70v582990ce49afd64d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:39052 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030266AbWA0NBt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Jan 2006 08:01:49 -0500
In-Reply-To: <7ac1e90c0601270433u3be68c70v582990ce49afd64d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bahadir Balban <bahadir.balban@gmail.com>
Cc: linux-ide@vger.kernel.org

Can we see your kernel config.

I suspect there is no support compiled in for usb storage devices.


Bahadir Balban wrote:
> Hi,
>
> I am trying to mount a usb flash disk on a platform that needs it's
> usb controller and driver tested. The drive mounts on a Gentoo-2.6.11
> host machine without problems:
>
> % mount -t vfat /dev/sdc1 /mnt/usbflash
>
> On the testing embedded linux platform (linux 2.6.9) however, it fails:
> % mount -t vfat /dev/sda1 /mnt/usbflash
> mount: /dev/sda1 is not a valid block device
>
> trying /dev/sda does not help either:
> % mount -t vfat /dev/sda /mnt/usbdisk
> FAT: invalid media value (0xb9)
> VFS: Can't find a valid FAT filesystem on dev sda.
> mount: wrong fs type, bad option, bad superblock on /dev/sda, or too
> many mounted file systems
>
> On both kernels vfat partitions are enabled. I was suspecting that the
> usb transactions might have been faulty on the testing platform, and
> therefore not returning the right data. But,
> %  dd if=/dev/sdc count=1 | hexdump -C
>
> gives the same output on both the working platform and test platforms.
> Outputs given below.
>
> If the outputs are the same, what what's the problem on one of the
> machines? If the vfat partition table below is not valid, why would it
> mount successfully on one of the machines?
>
> Many thanks,
> Bahadir
>
>
> Output on GentooLinux-2.6.11, with working usb controller and driver,
> and successful mount:
> % dd if=/dev/sdc count=1 | hexdump -C
>
> 1+0 records in
> 1+0 records out
> 00000000  33 c0 8e d0 bc 00 7c fb  50 07 50 1f fc be 1b 7c  |3.....|.P.P....||
> 00000010  bf 1b 06 50 57 b9 e5 01  f3 a4 cb be be 07 b1 04  |...PW...........|
> 00000020  38 2c 7c 09 75 15 83 c6  10 e2 f5 cd 18 8b 14 8b  |8,|.u...........|
> 00000030  ee 83 c6 10 49 74 16 38  2c 74 f6 be 10 07 4e ac  |....It.8,t....N.|
> 00000040  3c 00 74 fa bb 07 00 b4  0e cd 10 eb f2 89 46 25  |<.t...........F%|
> 00000050  96 8a 46 04 b4 06 3c 0e  74 11 b4 0b 3c 0c 74 05  |..F...<.t...<.t.|
> 00000060  3a c4 75 2b 40 c6 46 25  06 75 24 bb aa 55 50 b4  |:.u+@.F%.u$..UP.|
> 00000070  41 cd 13 58 72 16 81 fb  55 aa 75 10 f6 c1 01 74  |A..Xr...U.u....t|
> 00000080  0b 8a e0 88 56 24 c7 06  a1 06 eb 1e 88 66 04 bf  |....V$.......f..|
> 00000090  0a 00 b8 01 02 8b dc 33  c9 83 ff 05 7f 03 8b 4e  |.......3.......N|
> 000000a0  25 03 4e 02 cd 13 72 29  be 46 07 81 3e fe 7d 55  |%.N...r).F..>.}U|
> 000000b0  aa 74 5a 83 ef 05 7f da  85 f6 75 83 be 27 07 eb  |.tZ.......u..'..|
> 000000c0  8a 98 91 52 99 03 46 08  13 56 0a e8 12 00 5a eb  |...R..F..V....Z.|
> 000000d0  d5 4f 74 e4 33 c0 cd 13  eb b8 00 00 00 00 00 00  |.Ot.3...........|
> 000000e0  56 33 f6 56 56 52 50 06  53 51 be 10 00 56 8b f4  |V3.VVRP.SQ...V..|
> 000000f0  50 52 b8 00 42 8a 56 24  cd 13 5a 58 8d 64 10 72  |PR..B.V$..ZX.d.r|
> 00000100  0a 40 75 01 42 80 c7 02  e2 f7 f8 5e c3 eb 74 49  |.@u.B......^..tI|
> 00000110  6e 76 61 6c 69 64 20 70  61 72 74 69 74 69 6f 6e  |nvalid partition|
> 00000120  20 74 61 62 6c 65 00 45  72 72 6f 72 20 6c 6f 61  | table.Error loa|
> 00000130  64 69 6e 67 20 6f 70 65  72 61 74 69 6e 67 20 73  |ding operating s|
> 00000140  79 73 74 65 6d 00 4d 69  73 73 69 6e 67 20 6f 70  |ystem.Missing op|
> 00000150  65 72 61 74 69 6e 67 20  73 79 73 74 65 6d 00 00  |erating system..|
> 00000160  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 00000180  00 00 00 8b fc 1e 57 8b  f5 cb 00 00 00 00 00 00  |......W.........|
> 00000190  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 000001b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 80 01  |................|
> 000001c0  01 00 04 05 3f a7 3f 00  00 00 d1 f7 00 00 00 00  |....?.?.........|
> 000001d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> *
> 000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
>
>
> Output on embedded linux platform - its usb driver/controller are
> subject to testing:
> % dd if=/dev/sda count=1 | hexdump
>
> 1+0 records in
> 1+0 records out
> 00000000: 33 C0 8E D0 BC 00 7C FB 50 07 50 1F FC BE 1B 7C  3@.P<.|{P.P.|>.|
> 00000010: BF 1B 06 50 57 B9 E5 01 F3 A4 CB BE BE 07 B1 04  ?..PW9e.s$K>>.1.
> 00000020: 38 2C 7C 09 75 15 83 C6 10 E2 F5 CD 18 8B 14 8B  8,|.u..F.buM....
> 00000030: EE 83 C6 10 49 74 16 38 2C 74 F6 BE 10 07 4E AC  n.F.It.8,tv>..N,
> 00000040: 3C 00 74 FA BB 07 00 B4 0E CD 10 EB F2 89 46 25  <.tz;..4.M.kr.F%
> 00000050: 96 8A 46 04 B4 06 3C 0E 74 11 B4 0B 3C 0C 74 05  ..F.4.<.t.4.<.t.
> 00000060: 3A C4 75 2B 40 C6 46 25 06 75 24 BB AA 55 50 B4  :Du+@FF%.u$;*UP4
> 00000070: 41 CD 13 58 72 16 81 FB 55 AA 75 10 F6 C1 01 74  AM.Xr..{U*u.vA.t
> 00000080: 0B 8A E0 88 56 24 C7 06 A1 06 EB 1E 88 66 04 BF  ..`.V$G.!.k..f.?
> 00000090: 0A 00 B8 01 02 8B DC 33 C9 83 FF 05 7F 03 8B 4E  ..8...\3I......N
> 000000A0: 25 03 4E 02 CD 13 72 29 BE 46 07 81 3E FE 7D 55  %.N.M.r)>F..>~}U
> 000000B0: AA 74 5A 83 EF 05 7F DA 85 F6 75 83 BE 27 07 EB  *tZ.o..Z.vu.>'.k
> 000000C0: 8A 98 91 52 99 03 46 08 13 56 0A E8 12 00 5A EB  ...R..F..V.h..Zk
> 000000D0: D5 4F 74 E4 33 C0 CD 13 EB B8 00 00 00 00 00 00  UOtd3@M.k8......
> 000000E0: 56 33 F6 56 56 52 50 06 53 51 BE 10 00 56 8B F4  V3vVVRP.SQ>..V.t
> 000000F0: 50 52 B8 00 42 8A 56 24 CD 13 5A 58 8D 64 10 72  PR8.B.V$M.ZX.d.r
> 00000100: 0A 40 75 01 42 80 C7 02 E2 F7 F8 5E C3 EB 74 49  .@u.B.G.bwx^CktI
> 00000110: 6E 76 61 6C 69 64 20 70 61 72 74 69 74 69 6F 6E  nvalid partition
> 00000120: 20 74 61 62 6C 65 00 45 72 72 6F 72 20 6C 6F 61   table.Error loa
> 00000130: 64 69 6E 67 20 6F 70 65 72 61 74 69 6E 67 20 73  ding operating s
> 00000140: 79 73 74 65 6D 00 4D 69 73 73 69 6E 67 20 6F 70  ystem.Missing op
> 00000150: 65 72 61 74 69 6E 67 20 73 79 73 74 65 6D 00 00  erating system..
> 00000160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000180: 00 00 00 8B FC 1E 57 8B F5 CB 00 00 00 00 00 00  ....|.W.uK......
> 00000190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 000001A0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 000001B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 80 01  ................
> 000001C0: 01 00 04 05 3F A7 3F 00 00 00 D1 F7 00 00 00 00  ....?'?...Qw....
> 000001D0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 000001E0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 000001F0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 AA  ..............U*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   



	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de


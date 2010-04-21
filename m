From: Fang Wenqi <anton.fang@gmail.com>
Subject: Re: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Wed, 21 Apr 2010 22:57:11 +0800
Message-ID: <4BCF1247.8080508@gmail.com>
References: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn> <20100421152404.62699040@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f186.google.com ([209.85.222.186]:54550 "EHLO
	mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab0DUO4j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Apr 2010 10:56:39 -0400
Received: by pzk16 with SMTP id 16so3588052pzk.22
        for <linux-ide@vger.kernel.org>; Wed, 21 Apr 2010 07:56:39 -0700 (PDT)
In-Reply-To: <20100421152404.62699040@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@redhat.com, linux-ide@vger.kernel.org, antonf@turbolinux.com.cn


I'm using gcc 4.4.3 on Fedora 12:

$ gcc -v
Using built-in specs.
Target: i686-redhat-linux
Configured with: ../configure --prefix=3D/usr --mandir=3D/usr/share/man=
 --infodir=3D/usr/share/info=20
--with-bugurl=3Dhttp://bugzilla.redhat.com/bugzilla --enable-bootstrap =
--enable-shared=20
--enable-threads=3Dposix --enable-checking=3Drelease --with-system-zlib=
 --enable-__cxa_atexit=20
--disable-libunwind-exceptions --enable-gnu-unique-object=20
--enable-languages=3Dc,c++,objc,obj-c++,java,fortran,ada --enable-java-=
awt=3Dgtk --disable-dssi=20
--enable-plugin --with-java-home=3D/usr/lib/jvm/java-1.5.0-gcj-1.5.0.0/=
jre --enable-libgcj-multifile=20
--enable-java-maintainer-mode --with-ecj-jar=3D/usr/share/java/eclipse-=
ecj.jar=20
--disable-libjava-multilib --with-ppl --with-cloog --with-tune=3Dgeneri=
c --with-arch=3Di686=20
--build=3Di686-redhat-linux
Thread model: posix
gcc version 4.4.3 20100127 (Red Hat 4.4.3-4) (GCC)


On 04/21/2010 10:24 PM, Alan Cox wrote:
> On Wed, 21 Apr 2010 22:07:26 +0800
> Fang Wenqi<anton.fang@gmail.com>  wrote:
>
>>    CC      drivers/ata/libata-eh.o
>> drivers/ata/libata-eh.c: In function =E2=80=98ata_eh_analyze_ncq_err=
or=E2=80=99:
>> drivers/ata/libata-eh.c:1642: warning: =E2=80=98tf.flags=E2=80=99 ma=
y be used uninitialized in this function
>
> Which compiler are you using. gcc 4.4.3 seems to have no trouble work=
ing
> this out correctly and issues no warning ?
>


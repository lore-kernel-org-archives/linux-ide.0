From: Fang Wenqi <anton.fang@gmail.com>
Subject: Re: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Thu, 22 Apr 2010 09:23:26 +0800
Message-ID: <4BCFA50E.80800@gmail.com>
References: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn> <20100421152404.62699040@lxorguk.ukuu.org.uk> <4BCF1247.8080508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45406 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab0DVBZB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Apr 2010 21:25:01 -0400
Received: by gwj19 with SMTP id 19so1735951gwj.19
        for <linux-ide@vger.kernel.org>; Wed, 21 Apr 2010 18:25:00 -0700 (PDT)
In-Reply-To: <4BCF1247.8080508@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com, linux-ide@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, antonf@turbolinux.com.cn

Sorry that the title should be:
  "fix uninitialized variable warning"

not
"fix unused variable warning"


Need I re-send the patch mail ?


On 04/21/2010 10:57 PM, Fang Wenqi wrote:
>
> I'm using gcc 4.4.3 on Fedora 12:
>
> $ gcc -v
> Using built-in specs.
> Target: i686-redhat-linux
> Configured with: ../configure --prefix=3D/usr --mandir=3D/usr/share/m=
an
> --infodir=3D/usr/share/info
> --with-bugurl=3Dhttp://bugzilla.redhat.com/bugzilla --enable-bootstra=
p
> --enable-shared --enable-threads=3Dposix --enable-checking=3Drelease
> --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptio=
ns
> --enable-gnu-unique-object
> --enable-languages=3Dc,c++,objc,obj-c++,java,fortran,ada
> --enable-java-awt=3Dgtk --disable-dssi --enable-plugin
> --with-java-home=3D/usr/lib/jvm/java-1.5.0-gcj-1.5.0.0/jre
> --enable-libgcj-multifile --enable-java-maintainer-mode
> --with-ecj-jar=3D/usr/share/java/eclipse-ecj.jar
> --disable-libjava-multilib --with-ppl --with-cloog --with-tune=3Dgene=
ric
> --with-arch=3Di686 --build=3Di686-redhat-linux
> Thread model: posix
> gcc version 4.4.3 20100127 (Red Hat 4.4.3-4) (GCC)
>
>
> On 04/21/2010 10:24 PM, Alan Cox wrote:
>> On Wed, 21 Apr 2010 22:07:26 +0800
>> Fang Wenqi<anton.fang@gmail.com> wrote:
>>
>>> CC drivers/ata/libata-eh.o
>>> drivers/ata/libata-eh.c: In function =E2=80=98ata_eh_analyze_ncq_er=
ror=E2=80=99:
>>> drivers/ata/libata-eh.c:1642: warning: =E2=80=98tf.flags=E2=80=99 m=
ay be used
>>> uninitialized in this function
>>
>> Which compiler are you using. gcc 4.4.3 seems to have no trouble wor=
king
>> this out correctly and issues no warning ?
>>
>


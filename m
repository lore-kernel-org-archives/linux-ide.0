From: "Jonathan Bell" <doggs.lay.eggs@googlemail.com>
Subject: Re: Errors when copying between drives on a SiI3114 controller under kernel 2.6.18
Date: Mon, 09 Oct 2006 15:49:26 +0100
Message-ID: <op.tg5ssogyxci36i@akima>
References: <op.tg1yx12kxci36i@akima> <45287FA6.5020906@gmail.com> <op.tg3tyekpxci36i@akima> <452A0A86.8070107@gmail.com> <452A0BA6.8030401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:55402 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932913AbWJIOtW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Oct 2006 10:49:22 -0400
Received: by ug-out-1314.google.com with SMTP id o38so588706ugd
        for <linux-ide@vger.kernel.org>; Mon, 09 Oct 2006 07:49:21 -0700 (PDT)
In-Reply-To: <452A0BA6.8030401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, 09 Oct 2006 09:43:18 +0100, Tejun Heo <htejun@gmail.com> wrote:

> Tejun Heo wrote:
>> I cannot reproduce your problem here.  Can you retest after running the  
>> following commands?
>>  # setpci -s 01:07.0 0c.b=04
>> # setpci -s 01:08.0 0c.b=04
>
> I forgot something.
>
> * You need to make sata_sil a module.  Boot, unload sata_sil if loaded,  
> run above commands, load sata_sil and test.
>
> * If above commands don't work, try =00 instead of =04.
>
> Thanks.
>


setpci -s 01:07/8.0 0c.b=04 performed, sata_sil inserted...

md5sum crapped out again, similar errors in dmesg as before.

setpci -s 01:07/8.0 0c.b=00 performed, sata_sil inserted...

It worked...
cp ~/hugefile /mnt/sda1 && cp /mnt/sda1/hugefile /mnt/sdb1
&& md5sum /mnt/sda1/hugefile /mnt/sdb1/hugefile

ccf5f9052aa1fac3062c3f1920abb1fc  /mnt/sda1/hugefile
ccf5f9052aa1fac3062c3f1920abb1fc  /mnt/sdb1/hugefile

What does this register do, out of interest? With 00 it took ages and made  
my load average shoot up to about 6.50!




